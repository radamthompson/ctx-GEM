function [ newModel ] = setReferenceParams( model, c_source )
%setReferenceParams Set reference parameters for theoretical / exploratory
%FBA
%   This is a helper function for any script which is setting reference
%   parameters for exploratory smulations. Prominently used in
%   exploreEnergyBalance(). Sets  ammonia as sole nitrogen source, sulphate as sulphur source.
%
%   c_source = 'CB' %cellobiose
%   c_source = 'CE' %cellulose
%
% R. Adam Thompson
% Trinh Lab
% University of Tennessee, Knoxville
% rthomp46@utk.edu

newModel = model;

newModel=setParam(newModel,'lb','EXC_IN_m101',5); %GluEq
newModel=setParam(newModel,'ub','EXC_IN_m101',7.5); %

% Set up media
% Cellohexaose uptake
newModel=setParam(newModel,'ub','EXC_IN_m97',0);
newModel=setParam(newModel,'lb','EXC_IN_m97',0);
% Cellopentaose uptake
newModel=setParam(newModel,'ub','EXC_IN_m98',0);
newModel=setParam(newModel,'lb','EXC_IN_m98',0);
% Cellotriose uptake
newModel=setParam(newModel,'ub','EXC_IN_m100',0);
newModel=setParam(newModel,'lb','EXC_IN_m100',0);

switch c_source
    case 'CE'
        % Cellotetraose uptake
        newModel=setParam(newModel,'ub','EXC_IN_m99',1000);
        newModel=setParam(newModel,'lb','EXC_IN_m99',0);
        % Cellobiose uptake
        newModel=setParam(newModel,'ub','EXC_IN_m20',0);
        newModel=setParam(newModel,'lb','EXC_IN_m20',0);
    case 'CB'
        % Cellotetraose uptake
        newModel=setParam(newModel,'ub','EXC_IN_m99',0);
        newModel=setParam(newModel,'lb','EXC_IN_m99',0);
        % Cellobiose uptake
        newModel=setParam(newModel,'ub','EXC_IN_m20',1000);
        newModel=setParam(newModel,'lb','EXC_IN_m20',0);
end

newModel=setParam(newModel,'lb','EXC_IN_m17',0); %Ammonia
newModel=setParam(newModel,'ub','EXC_IN_m17',1000); %

newModel=setParam(newModel,'lb','EXC_IN_m21',0); %Urea
newModel=setParam(newModel,'ub','EXC_IN_m21',1000); %

newModel=setParam(newModel,'lb','EXC_IN_m29',0); %H2S
newModel=setParam(newModel,'ub','EXC_IN_m29',0); %

newModel=setParam(newModel,'ub','EXC_IN_m25',1000); %SO4
newModel=setParam(newModel,'lb','EXC_IN_m25',0);

newModel=setParam(newModel,'lb','EXC_BOTH_m31',0); %Ala
newModel=setParam(newModel,'lb','EXC_BOTH_m32',0); %Arg
newModel=setParam(newModel,'lb','EXC_BOTH_m33',0); %Asp
newModel=setParam(newModel,'lb','EXC_BOTH_m34',0); %Asn
newModel=setParam(newModel,'lb','EXC_BOTH_m35',-1); %Cys
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

% Fermentation products
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

% Ile
newModel=setParam(newModel,'ub','EXC_BOTH_m40',1000);

% Ala
newModel=setParam(newModel,'ub','EXC_BOTH_m31',1000);

% Lactate
newModel=setParam(newModel,'ub','EXC_OUT_m54',1000);
newModel=setParam(newModel,'lb','EXC_OUT_m54',0);

end