function [ newModel ] = applyFluxRatio( model, ratio, varargin )
%applyFluxRatio Add in a flux ratio constraint to a RAVEN GEM
%   Setting up a shell to add Flux Ratio constraints to a genome scale
%   model. That way I can add the constraints in a stepwise manner as I
%   come up with them and apply ratios in a softcoded manner. Original
%   constraint is glucose equivalents constraining cellodextrin import.
%
%   ratio :=
%       'gluEq'         Set up glucose equivalents ratio
%		'Neq'           Nitrogen equivalents ratio
%       'EA'            Ethanol: Acetate ratio, via EXC_ rxns
%       'EA2'           Ethanol: Acetate from acetyl-CoA
%       'FC'            Formate: CO2 ratio
%       'HF'            Hydrogen: Formate ratio
%       'YE+YA'     Sum of ethanol and acetate yields. argin should be mu or D
%       'gluEq2'    Glucose equivalents ratio with
%
%       varargin{1} := value for flux ratio
%
% R. Adam Thompson
% Trinh Lab
% University of Tennessee, Knoxville
% rthomp46@utk.edu
%
% Created: Aug 3, 2015
% Last edit: Feb 9, 2016
%	10/7/2016: Added some documentation


newModel = model;
rxns = model.rxns;
S = model.S;
S = full(S);
[m n] = size(S);
S = [S; zeros(1,n)];

switch ratio
    case 'gluEq' % Glucose equivalent flux ratio
        
        rHexIdx = strcmp(rxns,'EXC_IN_m97'); %Cellohexaose
        rPentIdx = strcmp(rxns,'EXC_IN_m98'); %Cellopentaose
        rTetIdx = strcmp(rxns,'EXC_IN_m99'); %Cellotetraose
        rTriIdx = strcmp(rxns,'EXC_IN_m100'); %Cellotriose
        rCBIdx = strcmp(rxns,'EXC_IN_m20'); %Cellobiose
        rGEqIdx = strcmp(rxns,'EXC_IN_m101'); %Glucose equivalents
        
        S(m+1,rHexIdx) = -6;
        S(m+1,rPentIdx) = -5;
        S(m+1,rTetIdx) = -4;
        S(m+1,rTriIdx) = -3;
        S(m+1,rCBIdx) = -2;
        S(m+1,rGEqIdx) = 1;
        
        S = sparse(S);
        
        newModel.S = S;
        newModel.b = [model.b; 0];
        newModel.mets = [model.mets; 'fr_glu_eq'];
        newModel.metNames = [model.metNames; 'FR_Glu_Eq'];
        if isfield(newModel,'metComps')
            newModel.metComps = [model.metComps; 1];
            newModel.metFormulas = [model.metFormulas; ' '];
            newModel.unconstrained = [model.unconstrained; 0];
        else
            newModel.metChEBIID = [model.metChEBIID; ' '];
            newModel.metKEGGID = [model.metKEGGID; ' '];
            newModel.metPubChemID = [model.metPubChemID; ' '];
            newModel.metInChIString = [model.metInChIString; ' '];
        end
        
    case 'Neq' % Nitrogen equivalents flux ratio
        
        rNH3Idx = strcmp(rxns,'EXC_IN_m17');
        rUreaIdx = strcmp(rxns,'EXC_IN_m21');
        rNEqIdx = strcmp(rxns,'EXC_IN_');
        
        S(m+1,rNH3Idx) = -1;
        S(m+1,rUreaIdx) = -2;
        S(m+1,rNEqIdx) = 1;
        
        S = sparse(S);
        
        newModel.S = S;
        newModel.b = [model.b; 0];
        newModel.mets = [model.mets; 'fr_nitr_eq'];
        newModel.metNames = [model.metNames; 'FR_Nitr_Eq'];
        if isfield(newModel,'metComps')
            newModel.metComps = [model.metComps; 1];
            newModel.metFormulas = [model.metFormulas; ' '];
            newModel.unconstrained = [model.unconstrained; 0];
        else
            newModel.metChEBIID = [model.metChEBIID; ' '];
            newModel.metKEGGID = [model.metKEGGID; ' '];
            newModel.metPubChemID = [model.metPubChemID; ' '];
            newModel.metInChIString = [model.metInChIString; ' '];
        end
        
    case 'EA' % Ethanol: Acetate ratio (mol:mol)
        
        value = varargin{1};
        
        rETHIdx = strcmp(rxns,'EXC_OUT_m51');
        rACEIdx = strcmp(rxns,'EXC_OUT_m52');
        
        S(m+1,rETHIdx) = -1;
        S(m+1,rACEIdx) = value;
        
        S = sparse(S);
        
        newModel.S = S;
        newModel.b = [model.b; 0];
        newModel.mets = [model.mets; 'fr_EA'];
        newModel.metNames = [model.metNames; 'FR_ETH-ACE'];
        if isfield(newModel,'metComps')
            newModel.metComps = [model.metComps; 1];
            newModel.metFormulas = [model.metFormulas; ' '];
            newModel.unconstrained = [model.unconstrained; 0];
        else
            newModel.metChEBIID = [model.metChEBIID; ' '];
            newModel.metKEGGID = [model.metKEGGID; ' '];
            newModel.metPubChemID = [model.metPubChemID; ' '];
            newModel.metInChIString = [model.metInChIString; ' '];
        end
        
    case 'FC' % Formate:CO2 ratio
        
        value = varargin{1};
        
        rFORIdx = strcmp(rxns,'EXC_OUT_m53');
        rCO2Idx = strcmp(rxns,'EXC_BOTH_m19');
        
        S(m+1,rFORIdx) = -1;
        S(m+1,rCO2Idx) = value;
        
        S = sparse(S);
        
        newModel.S = S;
        newModel.b = [model.b; 0];
        newModel.mets = [model.mets; 'fr_FC'];
        newModel.metNames = [model.metNames; 'FR_FOR-CO2'];
        if isfield(newModel,'metComps')
            newModel.metComps = [model.metComps; 1];
            newModel.metFormulas = [model.metFormulas; ' '];
            newModel.unconstrained = [model.unconstrained; 0];
        else
            newModel.metChEBIID = [model.metChEBIID; ' '];
            newModel.metKEGGID = [model.metKEGGID; ' '];
            newModel.metPubChemID = [model.metPubChemID; ' '];
            newModel.metInChIString = [model.metInChIString; ' '];
        end
        
    case 'HF'  %Hydrogen to Formate ratio
        
        value = varargin{1};
        
        rFORIdx = strcmp(rxns,'EXC_OUT_m53');
        rH2Idx = strcmp(rxns,'EXC_OUT_m55');
        
        S(m+1,rFORIdx) = value;
        S(m+1,rH2Idx) = -1;
        
        S = sparse(S);
        
        newModel.S = S;
        newModel.b = [model.b; 0];
        newModel.mets = [model.mets; 'fr_HF'];
        newModel.metNames = [model.metNames; 'FR_H2-FOR'];
        if isfield(newModel,'metComps')
            newModel.metComps = [model.metComps; 1];
            newModel.metFormulas = [model.metFormulas; ' '];
            newModel.unconstrained = [model.unconstrained; 0];
        else
            newModel.metChEBIID = [model.metChEBIID; ' '];
            newModel.metKEGGID = [model.metKEGGID; ' '];
            newModel.metPubChemID = [model.metPubChemID; ' '];
            newModel.metInChIString = [model.metInChIString; ' '];
        end
        
    case 'YE+YA'  % Sum of ethanol and acetate yields incorporated as flux ratio
        
        value = varargin{1};
        
        rETHIdx = strcmp(rxns,'EXC_OUT_m51');
        rACEIdx = strcmp(rxns,'EXC_OUT_m52');
        rGEqIdx = strcmp(rxns,'EXC_IN_m101');
        
        % val = -3 * value + 2;
        
        S(m+1,rETHIdx) = -1;
        S(m+1,rACEIdx) = -1;
        S(m+1,rGEqIdx) = value;
        
        S = sparse(S);
        
        newModel.S = S;
        newModel.b = [model.b; 0];
        newModel.mets = [model.mets; 'fr_YEYA'];
        newModel.metNames = [model.metNames; 'FR_YEYA'];
        if isfield(newModel,'metComps')
            newModel.metComps = [model.metComps; 1];
            newModel.metFormulas = [model.metFormulas; ' '];
            newModel.unconstrained = [model.unconstrained; 0];
        else
            newModel.metChEBIID = [model.metChEBIID; ' '];
            newModel.metKEGGID = [model.metKEGGID; ' '];
            newModel.metPubChemID = [model.metPubChemID; ' '];
            newModel.metInChIString = [model.metInChIString; ' '];
        end
        
    case 'EA2' %Ethanol: Acetate from acetyl-CoA
        
        value = varargin{1};
        
        rETHIdx = strcmp(rxns,'R_R00228_c');
        rACEIdx = strcmp(rxns,'R_R00230_c');
        
        S(m+1,rETHIdx) = -1;
        S(m+1,rACEIdx) = value;
        
        S = sparse(S);
        
        newModel.S = S;
        newModel.b = [model.b; 0];
        newModel.mets = [model.mets; 'fr_EA'];
        newModel.metNames = [model.metNames; 'FR_ETH-ACE'];
        if isfield(newModel,'metComps')
            newModel.metComps = [model.metComps; 1];
            newModel.metFormulas = [model.metFormulas; ' '];
            newModel.unconstrained = [model.unconstrained; 0];
        else
            newModel.metChEBIID = [model.metChEBIID; ' '];
            newModel.metKEGGID = [model.metKEGGID; ' '];
            newModel.metPubChemID = [model.metPubChemID; ' '];
            newModel.metInChIString = [model.metInChIString; ' '];
        end
        
    case 'gluEq2'  % Including glucose in the Flux Ratio
        
        rHexIdx = strcmp(rxns,'EXC_IN_m97'); %Cellohexaose
        rPentIdx = strcmp(rxns,'EXC_IN_m98'); %Cellopentaose
        rTetIdx = strcmp(rxns,'EXC_IN_m99'); %Cellotetraose
        rTriIdx = strcmp(rxns,'EXC_IN_m100'); %Cellotriose
        rCBIdx = strcmp(rxns,'EXC_IN_m20'); %Cellobiose
        rGLCIdx = strcmp(rxns,'EXC_IN_m114'); %Glucose
        rGEqIdx = strcmp(rxns,'EXC_IN_m101'); %Glucose equivalents
        
        S(m+1,rHexIdx) = -6;
        S(m+1,rPentIdx) = -5;
        S(m+1,rTetIdx) = -4;
        S(m+1,rTriIdx) = -3;
        S(m+1,rCBIdx) = -2;
        S(m+1,rGLCIdx) = -1;
        S(m+1,rGEqIdx) = 1;
        
        S = sparse(S);
        
        newModel.S = S;
        newModel.b = [model.b; 0];
        newModel.mets = [model.mets; 'fr_glu_eq'];
        newModel.metNames = [model.metNames; 'FR_Glu_Eq'];
        if isfield(newModel,'metComps')
            newModel.metComps = [model.metComps; 1];
            newModel.metFormulas = [model.metFormulas; ' '];
            newModel.unconstrained = [model.unconstrained; 0];
        else
            newModel.metChEBIID = [model.metChEBIID; ' '];
            newModel.metKEGGID = [model.metKEGGID; ' '];
            newModel.metPubChemID = [model.metPubChemID; ' '];
            newModel.metInChIString = [model.metInChIString; ' '];
        end
end

