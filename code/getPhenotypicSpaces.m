function [ spaces ] = getPhenotypicSpaces( model, varargin )
%getPhenotypicSpaces Perform a series of optimizations to trace phenotypic
%spaces
%
%   This function will calculate several phenotypic spaces given a certain
%   parameter, designed to work in tandem with 'exploreEnergyBalance.m'
%
% R. Adam Thompson
% Trinh Lab
% University of Tennessee, Knoxville
% rthomp46@utk.edu
%
% Created: Nov 19, 2015
% Last edit:


% Set growth rate / reference conditions
model = setPhenSpaceReferenceParams(model);

if ~isempty(varargin)
    mu = varargin{1};
else
    mu = 0.1;
end
model=setParam(model,'lb','EXC_OUT_m86',mu);
model=setParam(model,'ub','EXC_OUT_m86',mu);

% Initialize
array = [0:0.5:10];
h2 = cell(length(array),1);
iboh = cell(length(array),1);

% H2 vs ETH, IBOH vs ETH
for i = 1:length(array)
    newmodel=setParam(model,'lb','EXC_OUT_m51',array(i));
    newmodel=setParam(newmodel,'ub','EXC_OUT_m51',array(i));
    
    model2=setParam(newmodel,'obj','EXC_OUT_m55',1);
    h2{i} = optimizeCbModel(model2,'max',0,false);
    model3=setParam(newmodel,'obj','EXC_OUT_m109',1);
    iboh{i} = optimizeCbModel(model3,'max',0,false);    
end

spaces.array = array;
spaces.h2 = h2;
spaces.iboh = iboh;

end




function newModel = setPhenSpaceReferenceParams(model)

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

