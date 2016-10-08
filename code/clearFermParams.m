function [ newModel ] = clearFermParams( model )
%clearFermParams Default (1000,0) bounds on ethanol, acetate, etc.
%
%
%
% R. Adam Thompson
% Trinh Lab
% University of Tennessee, Knoxville
% rthomp46@utk.edu
%
% Created: July 24, 2015
% Last edit: Aug 6, 2015

newModel = model;


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
% Cellobiose uptake
newModel=setParam(newModel,'ub','EXC_IN_m20',1000);
newModel=setParam(newModel,'lb','EXC_IN_m20',0);
% Glucose Eq uptake
newModel=setParam(newModel,'ub','EXC_IN_m101',1000);
newModel=setParam(newModel,'lb','EXC_IN_m101',0);

% Ethanol Production
newModel=setParam(newModel,'ub','EXC_OUT_m51',1000);
newModel=setParam(newModel,'lb','EXC_OUT_m51',0);

% Acetate
newModel=setParam(newModel,'ub','EXC_OUT_m52',1000);
newModel=setParam(newModel,'lb','EXC_OUT_m52',0);

% CO2
newModel=setParam(newModel,'ub','EXC_BOTH_m19',1000);
newModel=setParam(newModel,'lb','EXC_BOTH_m19',0);

% Hydrogen
newModel=setParam(newModel,'ub','EXC_OUT_m55',1000);
newModel=setParam(newModel,'lb','EXC_OUT_m55',0);

% Formate
newModel=setParam(newModel,'ub','EXC_OUT_m53',1000);
newModel=setParam(newModel,'lb','EXC_OUT_m53',0);

% Valine
newModel=setParam(newModel,'ub','EXC_BOTH_m50',1000);
newModel=setParam(newModel,'lb','EXC_BOTH_m50',0);

% Ile
newModel=setParam(newModel,'ub','EXC_BOTH_m40',1000);
newModel=setParam(newModel,'lb','EXC_BOTH_m40',0);

% Ala
newModel=setParam(newModel,'ub','EXC_BOTH_m31',1000);
newModel=setParam(newModel,'lb','EXC_BOTH_m31',0.0);

% Lactate
newModel=setParam(newModel,'ub','EXC_OUT_m54',1000);
newModel=setParam(newModel,'lb','EXC_OUT_m54',0);

% Isobutanol
newModel=setParam(newModel,'ub','EXC_OUT_m109',1000);
newModel=setParam(newModel,'lb','EXC_OUT_m109',0);

% Fumarate
newModel=setParam(newModel,'ub','EXC_OUT_m110',1000);
newModel=setParam(newModel,'lb','EXC_OUT_m110',0);

% Malate
newModel=setParam(newModel,'ub','EXC_OUT_m105',1000);
newModel=setParam(newModel,'lb','EXC_OUT_m105',0);

% Meso-2,3 butanediol
newModel=setParam(newModel,'ub','EXC_OUT_m106',1000);
newModel=setParam(newModel,'lb','EXC_OUT_m106',0);

% RR-2,3 butanediol
newModel=setParam(newModel,'ub','EXC_OUT_m107',1000);
newModel=setParam(newModel,'lb','EXC_OUT_m107',0);

% Pyroglutamate
newModel=setParam(newModel,'ub','EXC_OUT_m108',1000);
newModel=setParam(newModel,'lb','EXC_OUT_m108',0);

% Pyruvate
newModel=setParam(newModel,'ub','EXC_OUT_m56',1000);
newModel=setParam(newModel,'lb','EXC_OUT_m56',0);

% Xylitol
newModel=setParam(newModel,'ub','EXC_OUT_m109',1000);
newModel=setParam(newModel,'lb','EXC_OUT_m109',0);

% Nitrogen
newModel=setParam(newModel,'ub','EXC_IN_m17',5); %NH3
newModel=setParam(newModel,'ub','EXC_IN_m21',5);  % Urea

end

