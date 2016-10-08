function [ newModel ] = setHydgPtaparam( model )
%setHydGparam Take a model and apply HydG Pta constraints
%   Experimental data constraints using HydG Pta strain
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

newModel=setParam(newModel,'ub','R_R00230_c',0); %PTA
newModel=setParam(newModel,'lb','R_R00230_c',0);

% Set Experimental Ranges
% CB uptake
newModel=setParam(newModel,'ub','EXC_IN_m20',2.424); 
newModel=setParam(newModel,'lb','EXC_IN_m20',2.424);

% Ethanol Production
newModel=setParam(newModel,'ub','EXC_OUT_m51',4.8991); 
newModel=setParam(newModel,'lb','EXC_OUT_m51',4.4071);

% Acetate
newModel=setParam(newModel,'ub','EXC_OUT_m52',0.7445); 
newModel=setParam(newModel,'lb','EXC_OUT_m52',0);

% CO2
% newModel=setParam(newModel,'ub','EXC_BOTH_m19',5.2593); 
% newModel=setParam(newModel,'lb','EXC_BOTH_m19',4.3660);

% Hydrogen
newModel=setParam(newModel,'ub','EXC_OUT_m55',4.0090); 
newModel=setParam(newModel,'lb','EXC_OUT_m55',2.3287);

% Formate
newModel=setParam(newModel,'ub','EXC_OUT_m53',0.7949); 
newModel=setParam(newModel,'lb','EXC_OUT_m53',0.6841);

% Valine
newModel=setParam(newModel,'ub','EXC_BOTH_m50',0.6209); 
newModel=setParam(newModel,'lb','EXC_BOTH_m50',0.4796);

% Lactate
newModel=setParam(newModel,'ub','EXC_OUT_m54',0.0513); 
newModel=setParam(newModel,'lb','EXC_OUT_m54',0);

% Ala
newModel=setParam(newModel,'ub','EXC_BOTH_m31',0.0510); 
newModel=setParam(newModel,'lb','EXC_BOTH_m31',0.0490);

% Ile
newModel=setParam(newModel,'ub','EXC_BOTH_m40',0.0716); 
newModel=setParam(newModel,'lb','EXC_BOTH_m40',0.0143);


end

