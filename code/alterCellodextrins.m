function [ newModel, solnMatrix ] = alterCellodextrins( model, expt )
%alterCellodextrins Walk through different cellodextrin sources and solveLP
%   This function walks through constraining only
%
%   model := RAVEN model
%   expt := Experimental conditions
%                    For Carbon source 'ce':
%            'low_lc'         5 g/L avicel in LC media (Data from Evert Holwerda)
%            'low_mtc'      5 g/L avicel in MTC media (Data from Evert Holwerda)
%
%
% R. Adam Thompson
% Trinh Lab
% University of Tennessee, Knoxville
% rthomp46@utk.edu
%
% Created: Aug 12, 2015
% Last edit: Feb 8, 2016

newModel = clearFermParams(model);
newModel = setExptParam(newModel,'ce',expt);

cdArray = {'G6','G5','G4','G3','G2','G1'};

solnMatrix = zeros(length(newModel.rxns),length(cdArray));

for i = 1:length(cdArray)
    
    newModel = changeCellodextrin(newModel, cdArray{i});
    %soln = optimizeCbModel(newModel,'max',0,false);
    soln = solveLP(newModel,1);
    solnMatrix(:,i) = soln.x;
    
end

end



