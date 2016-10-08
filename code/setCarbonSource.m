function [ newModel ] = setCarbonSource( model, c_source )
%setCarbonSource Set cellulose or cellobiose for C therm
%   This script takes a C therm GEM and sets either cellobiose or cellulose
%   for a carbon source. This script works for version 10.11 onwards with
%   an active cellulosome reaction
%
%   model := RAVEN model
%   c_source := string, 'cb' for cellobiose, 'ce' for cellulose
%
% R. Adam Thompson
% Trinh Lab
% University of Tennessee, Knoxville
% rthomp46@utk.edu
%
% Created: Aug 3, 2015
% Last edit: Dec 14, 2015

newModel = model;

switch c_source
    case 'cb'
        % Glucose equivalents uptake
        newModel=setParam(newModel,'ub','EXC_IN_m101',1000);
        newModel=setParam(newModel,'lb','EXC_IN_m101',0);
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
        % Cellobiose uptake, WT range
        newModel=setParam(newModel,'ub','EXC_IN_m20',3.7443);
        newModel=setParam(newModel,'lb','EXC_IN_m20',3.4158);
        
        equation = {'0.5285 Protein + 0.026 DNA + 0.0655 RNA + 0.076 Lipid + 0.2242 Cell Wall + 0.00494 Solute Pool + 0.0304 Total_LTA + 0.02 Cellulosome term => Cell Dry Weight no GAM'};
        newModel = changeRxns(newModel,'R_R_DCW',equation,2,'C_c',false);
        
    case 'ce'
        % Glucose equivalents uptake, from high substrate loading paper
        newModel=setParam(newModel,'ub','EXC_IN_m101',5.5);
        newModel=setParam(newModel,'lb','EXC_IN_m101',5.0);
        % Cellohexaose uptake
        newModel=setParam(newModel,'ub','EXC_IN_m97',1000);
        newModel=setParam(newModel,'lb','EXC_IN_m97',0);
        % Cellopentaose uptake
        newModel=setParam(newModel,'ub','EXC_IN_m98',1000);
        newModel=setParam(newModel,'lb','EXC_IN_m98',0);
        % Cellotetraose uptake
        newModel=setParam(newModel,'ub','EXC_IN_m99',1000);
        newModel=setParam(newModel,'lb','EXC_IN_m99',0);
        % Cellotriose uptake
        newModel=setParam(newModel,'ub','EXC_IN_m100',1000);
        newModel=setParam(newModel,'lb','EXC_IN_m100',0);
        % Cellobiose uptake, WT range
        newModel=setParam(newModel,'ub','EXC_IN_m20',1000);
        newModel=setParam(newModel,'lb','EXC_IN_m20',0);
        
        equation = {'0.5285 Protein + 0.026 DNA + 0.0655 RNA + 0.076 Lipid + 0.2242 Cell Wall + 0.00494 Solute Pool + 0.0304 Total_LTA + 0.2 Cellulosome term => Cell Dry Weight no GAM'};
        newModel = changeRxns(newModel,'R_R_DCW',equation,2,'C_c',false);
end






end

