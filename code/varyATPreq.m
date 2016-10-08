function [ newModel, plottable, GAM_solns ] = varyATPreq( model, c_source, term )
%varyATPreq Setup loop to fit ATP GAM/ cellulosome requirement
%   This script is designed to take a C. therm. GEM structure and
%   incrementally change the ATP requirement while returning the solutions
%   as well as a plottable array. The goal is to set experimental
%   constraints and then find GAM by fitting the growth rate
%
%   c_source := 'cb' for cellobiose, 'ce' for cellulose   **Run
%   setCarbonSource prior to this script
%
%   term := specify which ATP requirement to increment. 'GAM' for growth
%   associated maintenance, 'cellulosome' otherwise
%
%
% R. Adam Thompson
% Trinh Lab
% University of Tennessee, Knoxville
% rthomp46@utk.edu
%
% Created: Aug 6, 2015
% Last edit: Dec 14,2015

% Initialize
newModel = model;
GAM_array = [0:0.5:50];
GAM_solns = cell(size(GAM_array));
plottable = ones(length(GAM_array),2);

% Set cellulosome fraction on carbon source (see Zhang et Lynd, J Bact 2005)
switch c_source
    case 'cb'
        equation = sprintf( '%1.3f Protein + 0.026 DNA + 0.0655 RNA + 0.076 Lipid + 0.2242 Cell Wall + 0.00494 Solute Pool + 0.0304 Total_LTA + %1.4f Cellulosome term => Cell Dry Weight no GAM',0.5285, 0.02);
    case 'ce'
        equation = sprintf( '%1.3f Protein + 0.026 DNA + 0.0655 RNA + 0.076 Lipid + 0.2242 Cell Wall + 0.00494 Solute Pool + 0.0304 Total_LTA + %1.4f Cellulosome term => Cell Dry Weight no GAM',0.5285, 0.2);
end
equation = {equation};
newModel = changeRxns(newModel,'R_R_DCW',equation,2,'C_c',false);


switch term
    case 'GAM'
        
        for i = 1:length(GAM_array)
            gam = GAM_array(i);
            equation = sprintf('%1.3f H2O + %1.3f ATP + Cell Dry Weight no GAM => %1.3f ADP + %1.3f Orthophosphate + Biomass',gam,gam,gam,gam);
            equation = {equation};
            newModel = changeRxns(newModel,'R_R_BIO',equation,2,'C_c',false);
            GAM_solns{i} = solveLP(newModel);
            plottable(i,:) = [gam -GAM_solns{i}.f];
        end
        
    case 'cellulosome'
        for i = 1:length(GAM_array)
            gam = GAM_array(i);
            equation = sprintf('%1.3f H2O + %1.3f ATP + 0.4317 L-Glutamate + 0.6373 Glycine + 0.5581 L-Alanine + 0.441 L-Lysine + 0.5523 L-Aspartate + 0.2365 L-Arginine + 0.1871 L-Glutamine + 0.4942 L-Serine + 0.1469 L-Methionine + 0.1718 L-Tryptophan + 0.2851 L-Phenylalanine + 0.3235 L-Tyrosine + 0.0665 L-Cysteine + 0.5329 L-Leucine + 0.1099 L-Histidine + 0.4823 L-Proline + 0.5523 L-Asparagine + 0.506 L-Valine + 0.5572 L-Threonine + 0.4739 L-Isoleucine => %1.3f ADP + %1.3f Orthophosphate + Cellulosome term',40+gam,40+gam,40+gam,40+gam);
            equation = {equation};
            newModel = changeRxns(newModel,'R_R_Cellulosome',equation,2,'C_c',false);
            GAM_solns{i} = solveLP(newModel);
            plottable(i,:) = [gam -GAM_solns{i}.f];
        end
end

end

