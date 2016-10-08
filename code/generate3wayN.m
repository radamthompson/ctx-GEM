function [ x_array, NSurface, AASurface ] = generate3wayN( model, figName )
%generate3wayN Compare C and N uptake to AA secretion
%   This script will take a model and run a series of calculations designed
%   to compare carbon uptake, nitrogen uptake, and amino acid secretion as
%   a function of cell growth
%
%
%
% R. Adam Thompson
% Trinh Lab
% University of Tennessee, Knoxville
% rthomp46@utk.edu
%
% Created: July 25, 2015
% Last edit:

if nargin < 2
    printFig = 0;
else
    printFig = 1;
end

NewModel = resetFermParams(model);

% Initialize loop
CBupArray = [0:0.05:4];
muArray = [0:0.005:0.4];

SolnArray = cell(size(CBupArray));
FameArray = cell(size(CBupArray));
AaArray = cell(size(CBupArray));
NSurface = zeros(length(CBupArray),length(muArray));
AASurface = zeros(length(CBupArray),length(muArray));

NH3idx = find(strcmp(model.rxns,'EXC_IN_m17'));
NewModel=setParam(NewModel,'obj','EXC_IN_m17',1);

max_count = length(CBupArray)*length(muArray);
x_array = zeros(length(model.rxns),max_count);

count = 0;
% Loop through CB up array, get N and amino acids
for i = 1:length(CBupArray)
    NewModel=setParam(NewModel,'ub','EXC_IN_m20',CBupArray(i));
    NewModel=setParam(NewModel,'lb','EXC_IN_m20',CBupArray(i));
    for j = 1:length(muArray)
        NewModel=setParam(NewModel,'ub','R_R_BIO',muArray(j));
        NewModel=setParam(NewModel,'lb','R_R_BIO',muArray(j));
        try
            soln =solveLP(NewModel);
            count = count + 1;
        catch
            NSurface(i,j) = 0;
             AASurface(i,j) = 0;
             count = count + 1;
             x_array(:,count) = zeros(length(model.rxns),1);
                     end
        if soln.stat == -1
            NSurface(i,j) = 0;
            AASurface(i,j) = 0;
            x_array(:,count) = zeros(length(model.rxns),1);
        else
            AaArray = getAminoAcids(NewModel, soln);
            x_array(:,count) = soln.x;
            AminoAcids = sum(AaArray);
            Ammonia = soln.x(NH3idx);
            NSurface(i,j) =Ammonia;
            AASurface(i,j) =AminoAcids;
            
        end
    end
end

surf(CBupArray,muArray,NSurface')

if printFig == 1
    h =  surf(NSurface(:,2),NSurface(:,1),CBupArray,NSurface(:,3))
end

end


function NewModel = resetFermParams(model)
%resetFermParameters Clear experimental constraints on fermentation profile

NewModel = model;

% CB uptake
NewModel=setParam(NewModel,'ub','EXC_IN_m20',3.5);
NewModel=setParam(NewModel,'lb','EXC_IN_m20',0);

% NH4 uptake
NewModel=setParam(NewModel,'ub','EXC_IN_m17',1000);
NewModel=setParam(NewModel,'lb','EXC_IN_m17',0);

% Ethanol
NewModel=setParam(NewModel,'ub','EXC_OUT_m51',1000);
NewModel=setParam(NewModel,'lb','EXC_OUT_m51',0);

% Acetate
NewModel=setParam(NewModel,'ub','EXC_OUT_m52',1000);
NewModel=setParam(NewModel,'lb','EXC_OUT_m52',0);

% CO2
NewModel=setParam(NewModel,'ub','EXC_BOTH_m19',1000);
NewModel=setParam(NewModel,'lb','EXC_BOTH_m19',0);

% Hydrogen
NewModel=setParam(NewModel,'ub','EXC_OUT_m55',1000);
NewModel=setParam(NewModel,'lb','EXC_OUT_m55',0);

% Formate
NewModel=setParam(NewModel,'ub','EXC_OUT_m53',1000);
NewModel=setParam(NewModel,'lb','EXC_OUT_m53',0);

% Valine
NewModel=setParam(NewModel,'ub','EXC_BOTH_m50',1000);
NewModel=setParam(NewModel,'lb','EXC_BOTH_m50',0);

% Lactate
NewModel=setParam(NewModel,'ub','EXC_OUT_m54',1000);
NewModel=setParam(NewModel,'lb','EXC_OUT_m54',0);

% Ala
NewModel=setParam(NewModel,'ub','EXC_BOTH_m31',1000);
NewModel=setParam(NewModel,'lb','EXC_BOTH_m31',0);

% Ile
NewModel=setParam(NewModel,'ub','EXC_BOTH_m40',1000);
NewModel=setParam(NewModel,'lb','EXC_BOTH_m40',0);

end

function AminoAcids = getAminoAcids(model, soln)
%getAminoAcids Pull total amino acid flux for a LP solution

%Initialize
AaExRxns = {'EXC_BOTH_m31';'EXC_BOTH_m32';'EXC_BOTH_m33';'EXC_BOTH_m34';'EXC_BOTH_m35';'EXC_BOTH_m36';'EXC_BOTH_m37';'EXC_BOTH_m38';'EXC_BOTH_m39';'EXC_BOTH_m40';'EXC_BOTH_m41';'EXC_BOTH_m42';'EXC_BOTH_m43';'EXC_BOTH_m44';'EXC_BOTH_m45';'EXC_BOTH_m46';'EXC_BOTH_m47';'EXC_BOTH_m48';'EXC_BOTH_m49';'EXC_BOTH_m50'};
rxnidx = ones(size(AaExRxns));
AminoAcids = zeros(size(AaExRxns));

% Get indicies
for i = 1:length(AaExRxns)
    idx = find(strcmp(model.rxns,AaExRxns{i}));
    rxnidx(i) = idx;
end

% Get AA fluxes
AminoAcids = soln.x(rxnidx);



end