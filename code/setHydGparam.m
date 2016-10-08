function [ newModel ] = setHydGparam( model )
%setHydGparam Take a model and apply HydG constraints
%   Experimental data constraints using HydG strain
%
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

% KO HydG Reactions
newModel=setParam(newModel,'ub','R_R07181_c',0); %OPM7r, Fe-H2
newModel=setParam(newModel,'lb','R_R07181_c',0);

newModel=setParam(newModel,'ub','R_R09508_c',0); %OPM8r, BIF
newModel=setParam(newModel,'lb','R_R09508_c',0);

% Set Experimental Ranges
% CB uptake
newModel=setParam(newModel,'ub','EXC_IN_m20',3.432); 
newModel=setParam(newModel,'lb','EXC_IN_m20',3.432);

% Ethanol Production
newModel=setParam(newModel,'ub','EXC_OUT_m51',4.9778); 
newModel=setParam(newModel,'lb','EXC_OUT_m51',4.9453);

% Acetate
newModel=setParam(newModel,'ub','EXC_OUT_m52',2.8097); 
newModel=setParam(newModel,'lb','EXC_OUT_m52',1.6628);

% CO2
%newModel=setParam(newModel,'ub','EXC_BOTH_m19',6.5841); 
newModel=setParam(newModel,'lb','EXC_BOTH_m19',6.4848);

% Hydrogen
newModel=setParam(newModel,'ub','EXC_OUT_m55',9.4965); 
newModel=setParam(newModel,'lb','EXC_OUT_m55',8.7181);

% Formate
newModel=setParam(newModel,'ub','EXC_OUT_m53',1.8181); 
newModel=setParam(newModel,'lb','EXC_OUT_m53',0.6263);

% Valine
newModel=setParam(newModel,'ub','EXC_BOTH_m50',0.3803); 
newModel=setParam(newModel,'lb','EXC_BOTH_m50',0.3225);

% Ile
newModel=setParam(newModel,'ub','EXC_BOTH_m40',0.0347); 
newModel=setParam(newModel,'lb','EXC_BOTH_m40',0.0345);

% Ala
newModel=setParam(newModel,'ub','EXC_BOTH_m31',0.0848); 
newModel=setParam(newModel,'lb','EXC_BOTH_m31',0.0585);

% Lactate
newModel=setParam(newModel,'ub','EXC_OUT_m54',0); 
newModel=setParam(newModel,'lb','EXC_OUT_m54',0);


end

