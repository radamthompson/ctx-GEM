function newModel = changeCellodextrin(model, cd)
%changeCellodextrin alter primary cellodextrin utilized
%   This function is used by alterCellodextrins
%
% R. Adam Thompson
% Trinh Lab
% University of Tennessee, Knoxville
% rthomp46@utk.edu
%
% Created: Aug 12, 2015
newModel = model;

switch cd
    
    case 'G6'
        
        % Cellohexaose uptake
        newModel=setParam(newModel,'ub','EXC_IN_m97',1000);
        newModel=setParam(newModel,'lb','EXC_IN_m97',0);
        % Cellopentaose uptake
        newModel=setParam(newModel,'ub','EXC_IN_m98',0);
        newModel=setParam(newModel,'lb','EXC_IN_m98',0);
        % Cellotetraose uptake
        newModel=setParam(newModel,'ub','EXC_IN_m99',0);
        newModel=setParam(newModel,'lb','EXC_IN_m99',0);
        % Cellotriose uptake
        newModel=setParam(newModel,'ub','EXC_IN_m100',0);
        newModel=setParam(newModel,'lb','EXC_IN_m100',0);
        % Cellobiose uptake
        newModel=setParam(newModel,'ub','EXC_IN_m20',0);
        newModel=setParam(newModel,'lb','EXC_IN_m20',0);
        % Glucose uptake
        newModel=setParam(newModel,'ub','EXC_IN_m114',0);
        newModel=setParam(newModel,'lb','EXC_IN_m114',0);
        
    case 'G5'
        
        % Cellohexaose uptake
        newModel=setParam(newModel,'ub','EXC_IN_m97',0);
        newModel=setParam(newModel,'lb','EXC_IN_m97',0);
        % Cellopentaose uptake
        newModel=setParam(newModel,'ub','EXC_IN_m98',1000);
        newModel=setParam(newModel,'lb','EXC_IN_m98',0);
        % Cellotetraose uptake
        newModel=setParam(newModel,'ub','EXC_IN_m99',0);
        newModel=setParam(newModel,'lb','EXC_IN_m99',0);
        % Cellotriose uptake
        newModel=setParam(newModel,'ub','EXC_IN_m100',0);
        newModel=setParam(newModel,'lb','EXC_IN_m100',0);
        % Cellobiose uptake
        newModel=setParam(newModel,'ub','EXC_IN_m20',0);
        newModel=setParam(newModel,'lb','EXC_IN_m20',0);
        % Glucose uptake
        newModel=setParam(newModel,'ub','EXC_IN_m114',0);
        newModel=setParam(newModel,'lb','EXC_IN_m114',0);
        
        
    case 'G4'
        
        % Cellohexaose uptake
        newModel=setParam(newModel,'ub','EXC_IN_m97',0);
        newModel=setParam(newModel,'lb','EXC_IN_m97',0);
        % Cellopentaose uptake
        newModel=setParam(newModel,'ub','EXC_IN_m98',0);
        newModel=setParam(newModel,'lb','EXC_IN_m98',0);
        % Cellotetraose uptake
        newModel=setParam(newModel,'ub','EXC_IN_m99',1000);
        newModel=setParam(newModel,'lb','EXC_IN_m99',0);
        % Cellotriose uptake
        newModel=setParam(newModel,'ub','EXC_IN_m100',0);
        newModel=setParam(newModel,'lb','EXC_IN_m100',0);
        % Cellobiose uptake
        newModel=setParam(newModel,'ub','EXC_IN_m20',0);
        newModel=setParam(newModel,'lb','EXC_IN_m20',0);
        % Glucose uptake
        newModel=setParam(newModel,'ub','EXC_IN_m114',0);
        newModel=setParam(newModel,'lb','EXC_IN_m114',0);
        
    case 'G3'
        
        % Cellohexaose uptake
        newModel=setParam(newModel,'ub','EXC_IN_m97',0);
        newModel=setParam(newModel,'lb','EXC_IN_m97',0);
        % Cellopentaose uptake
        newModel=setParam(newModel,'ub','EXC_IN_m98',0);
        newModel=setParam(newModel,'lb','EXC_IN_m98',0);
        % Cellotetraose uptake
        newModel=setParam(newModel,'ub','EXC_IN_m99',0);
        newModel=setParam(newModel,'lb','EXC_IN_m99',0);
        % Cellotriose uptake
        newModel=setParam(newModel,'ub','EXC_IN_m100',1000);
        newModel=setParam(newModel,'lb','EXC_IN_m100',0);
        % Cellobiose uptake
        newModel=setParam(newModel,'ub','EXC_IN_m20',0);
        newModel=setParam(newModel,'lb','EXC_IN_m20',0);
        % Glucose uptake
        newModel=setParam(newModel,'ub','EXC_IN_m114',0);
        newModel=setParam(newModel,'lb','EXC_IN_m114',0);
        
    case 'G2'
        
        % Cellohexaose uptake
        newModel=setParam(newModel,'ub','EXC_IN_m97',0);
        newModel=setParam(newModel,'lb','EXC_IN_m97',0);
        % Cellopentaose uptake
        newModel=setParam(newModel,'ub','EXC_IN_m98',0);
        newModel=setParam(newModel,'lb','EXC_IN_m98',0);
        % Cellotetraose uptake
        newModel=setParam(newModel,'ub','EXC_IN_m99',0);
        newModel=setParam(newModel,'lb','EXC_IN_m99',0);
        % Cellotriose uptake
        newModel=setParam(newModel,'ub','EXC_IN_m100',0);
        newModel=setParam(newModel,'lb','EXC_IN_m100',0);
        % Cellobiose uptake
        newModel=setParam(newModel,'ub','EXC_IN_m20',1000);
        newModel=setParam(newModel,'lb','EXC_IN_m20',0);
        % Glucose uptake
        newModel=setParam(newModel,'ub','EXC_IN_m114',0);
        newModel=setParam(newModel,'lb','EXC_IN_m114',0);
        
    case 'G1'
        
        % Cellohexaose uptake
        newModel=setParam(newModel,'ub','EXC_IN_m97',0);
        newModel=setParam(newModel,'lb','EXC_IN_m97',0);
        % Cellopentaose uptake
        newModel=setParam(newModel,'ub','EXC_IN_m98',0);
        newModel=setParam(newModel,'lb','EXC_IN_m98',0);
        % Cellotetraose uptake
        newModel=setParam(newModel,'ub','EXC_IN_m99',0);
        newModel=setParam(newModel,'lb','EXC_IN_m99',0);
        % Cellotriose uptake
        newModel=setParam(newModel,'ub','EXC_IN_m100',0);
        newModel=setParam(newModel,'lb','EXC_IN_m100',0);
        % Cellobiose uptake
        newModel=setParam(newModel,'ub','EXC_IN_m20',0);
        newModel=setParam(newModel,'lb','EXC_IN_m20',0);
        % Glucose uptake
        newModel=setParam(newModel,'ub','EXC_IN_m114',1000);
        newModel=setParam(newModel,'lb','EXC_IN_m114',0);
        
end

end


