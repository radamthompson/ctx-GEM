function [ newModel ] = alterCellulosomeFraction( model, percent )
%alterCellulosomeFraction Part of parameter exploration module
%
%   This script takes in a RAVEN version of Cth1313_v12 and later and
%   changes the percent of the dry cell weight is represented by the
%   cellulosome.
%
% R. Adam Thompson
% Trinh Lab
% University of Tennessee, Knoxville
% rthomp46@utk.edu
%
% Created: Oct 28, 2015
% Last edit: Dec 14, 2015

newModel = model;

pro = 0.5285;
if percent < 1
    cell = percent;
else
    cell = percent / 100;
end
% if cell > pro
    % error('Percent input is higher than total protein percent')
% end
% protein = pro - cell;

equation = sprintf('%1.4f Protein + 0.026 DNA + 0.0655 RNA + 0.076 Lipid + 0.2242 Cell Wall + 0.00494 Solute Pool + 0.0304 Total_LTA + %1.4f Cellulosome term => Cell Dry Weight no GAM',pro,cell)
equation = {equation};
newModel = changeRxns(newModel,'R_R_DCW',equation,2,'C_c',false);

end

