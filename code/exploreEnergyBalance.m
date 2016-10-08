function [ landscape ] = exploreEnergyBalance( model, varargin )
%exploreEnergyBalance Exploring biomass degradation vs fermentation
%landscape
%   This function will perform the standard exploration into the energetic
%   landscape of C. thermocellum. The input model will be part of an
%   iterative parameter perturbation and the output structure will contain
%   a series of flux distributions describing alternative objective
%   functions
%
% R. Adam Thompson
% Trinh Lab
% University of Tennessee, Knoxville
% rthomp46@utk.edu
%
% Created: Nov 19, 2015
% Last edit:

% Initialize
model = setExploringReferenceParams(model);
if ~isempty(varargin)
    mu = varargin{1};
else
    mu = 0.1;
end

% Opt Growth
model1=setParam(model,'obj','EXC_OUT_m86',1);
landscape.mu = optimizeCbModel(model1,'max',0,false);

% Opt ethanol with set growth rate
model2=setParam(model,'lb','EXC_OUT_m86',mu);
model2=setParam(model2,'ub','EXC_OUT_m86',mu);
model3=setParam(model2,'obj','EXC_OUT_m51',1);
landscape.eth = optimizeCbModel(model3,'max',0,false);

% Opt ACE with set growth rate
model8=setParam(model2,'obj','EXC_OUT_m52',1);
landscape.ace = optimizeCbModel(model8,'max',0,false);

% Opt H2 with set growth rate
model4=setParam(model2,'obj','EXC_OUT_m55',1);
landscape.h2 = optimizeCbModel(model4,'max',0,false);

% Opt iBuOH with set growth rate
model5=setParam(model2,'obj','EXC_OUT_m109',1);
landscape.iboh = optimizeCbModel(model5,'max',0,false);

% Opt alcohols with set growth rate
model6=setParam(model2,'obj',{'EXC_OUT_m51','EXC_OUT_m109'},[0.5,1]);
landscape.ols = optimizeCbModel(model6,'max',0,false);

% Opt all 3 with set growth rate
model7=setParam(model2,'obj',{'EXC_OUT_m51','EXC_OUT_m55','EXC_OUT_m109'},[0.5,0.25,1]);
landscape.all = optimizeCbModel(model7,'max',0,false);

end



function newModel = setExploringReferenceParams(model)

newModel = model;

newModel=setParam(newModel,'lb','EXC_IN_m101',0); %GluEq
newModel=setParam(newModel,'ub','EXC_IN_m101',5); %

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

model=setParam(model,'lb','EXC_IN_m17',0); %Ammonia
model=setParam(model,'ub','EXC_IN_m17',1000); %

model=setParam(model,'lb','EXC_IN_m21',0); %Urea
model=setParam(model,'ub','EXC_IN_m21',0); %

model=setParam(model,'lb','EXC_IN_m29',0); %H2S
model=setParam(model,'ub','EXC_IN_m29',0); %

newModel=setParam(newModel,'lb','EXC_BOTH_m31',0); %Ala
newModel=setParam(newModel,'lb','EXC_BOTH_m32',0); %Arg
newModel=setParam(newModel,'lb','EXC_BOTH_m33',0); %Asp
newModel=setParam(newModel,'lb','EXC_BOTH_m34',0); %Asn
newModel=setParam(newModel,'lb','EXC_BOTH_m35',0); %Cys
newModel=setParam(newModel,'lb','EXC_BOTH_m36',0); %Glu
newModel=setParam(newModel,'lb','EXC_BOTH_m37',0); %Gln
newModel=setParam(newModel,'lb','EXC_BOTH_m38',0); %Gly
newModel=setParam(newModel,'lb','EXC_BOTH_m39',0); %His
newModel=setParam(newModel,'lb','EXC_BOTH_m40',0); %Iso
newModel=setParam(newModel,'lb','EXC_BOTH_m41',0); %Leu
newModel=setParam(newModel,'lb','EXC_BOTH_m42',0); %Lys
newModel=setParam(newModel,'lb','EXC_BOTH_m43',0); %Met
newModel=setParam(newModel,'lb','EXC_BOTH_m44',0); %Phe
newModel=setParam(newModel,'lb','EXC_BOTH_m45',0); %Pro
newModel=setParam(newModel,'lb','EXC_BOTH_m46',0); %Ser
newModel=setParam(newModel,'lb','EXC_BOTH_m47',0); %Thr
newModel=setParam(newModel,'lb','EXC_BOTH_m48',0); %Trp
newModel=setParam(newModel,'lb','EXC_BOTH_m49',0); %Tyr
newModel=setParam(newModel,'lb','EXC_BOTH_m50',0); %Val

end


