function [ newModel ] = setWTparam( model )
%setWTparam Take a model and apply WT constraints
%   Experimental data constraints using WT strain
%
%
% R. Adam Thompson
% Trinh Lab
% University of Tennessee, Knoxville
% rthomp46@utk.edu
%
% Created: July 24, 2015
% Last edit: 

newModel = model;

% Set Experimental Ranges
% CB uptake
newModel=setParam(newModel,'ub','EXC_IN_m20',3.7443); 
newModel=setParam(newModel,'lb','EXC_IN_m20',3.4158);

% Ethanol Production
newModel=setParam(newModel,'ub','EXC_OUT_m51',4.2894); 
newModel=setParam(newModel,'lb','EXC_OUT_m51',4.0805);

% Acetate
newModel=setParam(newModel,'ub','EXC_OUT_m52',2.7182); 
newModel=setParam(newModel,'lb','EXC_OUT_m52',2.5465);

% CO2
%newModel=setParam(newModel,'ub','EXC_BOTH_m19',8.264); 
newModel=setParam(newModel,'lb','EXC_BOTH_m19',6.8177);

% Hydrogen
newModel=setParam(newModel,'ub','EXC_OUT_m55',8.2357); 
newModel=setParam(newModel,'lb','EXC_OUT_m55',7.4882);

% Formate
newModel=setParam(newModel,'ub','EXC_OUT_m53',1.7770); 
newModel=setParam(newModel,'lb','EXC_OUT_m53',1.7600);

% Valine
newModel=setParam(newModel,'ub','EXC_BOTH_m50',0.8963); 
newModel=setParam(newModel,'lb','EXC_BOTH_m50',0.6560);

% Ile
newModel=setParam(newModel,'ub','EXC_BOTH_m40',0.1184); 
newModel=setParam(newModel,'lb','EXC_BOTH_m40',0.0871);

% Ala
newModel=setParam(newModel,'ub','EXC_BOTH_m31',0.0); 
newModel=setParam(newModel,'lb','EXC_BOTH_m31',0.0);

% Lactate
newModel=setParam(newModel,'ub','EXC_OUT_m54',0.1932); 
newModel=setParam(newModel,'lb','EXC_OUT_m54',0.1749);


end

