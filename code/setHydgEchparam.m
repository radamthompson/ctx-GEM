function [ newModel ] = setHydgEchparam( model )
%setHydGparam Take a model and apply HydG Ech constraints
%   Experimental data constraints using HydG Ech strain
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
newModel=setParam(newModel,'ub','R_R07181_c',0); % OPM7r, Fe-H2
newModel=setParam(newModel,'lb','R_R07181_c',0);

newModel=setParam(newModel,'ub','R_R09508_c',0); % OPM8r, BIF
newModel=setParam(newModel,'lb','R_R09508_c',0);

newModel=setParam(newModel,'ub','R_R00019_c',0); % FEM14, ECH
newModel=setParam(newModel,'lb','R_R00019_c',0);

% Set Experimental Ranges
% CB uptake
newModel=setParam(newModel,'ub','EXC_IN_m20',3.3256);
newModel=setParam(newModel,'lb','EXC_IN_m20',3.3256); 

% Ethanol Production
newModel=setParam(newModel,'ub','EXC_OUT_m51',9.3162); 
newModel=setParam(newModel,'lb','EXC_OUT_m51',6.5818);

% Acetate
newModel=setParam(newModel,'ub','EXC_OUT_m52',0.8319); 
newModel=setParam(newModel,'lb','EXC_OUT_m52',0.5013);

% CO2
newModel=setParam(newModel,'ub','EXC_BOTH_m19',7.1891); 
newModel=setParam(newModel,'lb','EXC_BOTH_m19',5.0503);

% Hydrogen
newModel=setParam(newModel,'ub','EXC_OUT_m55',0.6457); 
newModel=setParam(newModel,'lb','EXC_OUT_m55',0);

% Formate
newModel=setParam(newModel,'ub','EXC_OUT_m53',3.1080); 
newModel=setParam(newModel,'lb','EXC_OUT_m53',2.9209);

% Valine
newModel=setParam(newModel,'ub','EXC_BOTH_m50',0.3143); 
newModel=setParam(newModel,'lb','EXC_BOTH_m50',0.3089);

% Ile
newModel=setParam(newModel,'ub','EXC_BOTH_m40',0.0673); 
newModel=setParam(newModel,'lb','EXC_BOTH_m40',0.0300);

% Ala
newModel=setParam(newModel,'ub','EXC_BOTH_m31',0.0360); 
newModel=setParam(newModel,'lb','EXC_BOTH_m31',0.0209);

% Lactate
newModel=setParam(newModel,'ub','EXC_OUT_m54',0.0470); 
newModel=setParam(newModel,'lb','EXC_OUT_m54',0.0422);

end

