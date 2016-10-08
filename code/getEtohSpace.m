function [ NewModel, SolnArray, FameArray, PhenSpace ] = getEtohSpace( model )
%getEtohSpace Find ethanol vs mu phenotypic space
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

% if statement for printing

NewModel = resetFermParams(model);

% Set ETOH param and as obj.
NewModel=setParam(NewModel,'ub','EXC_OUT_m51',1000);
NewModel=setParam(NewModel,'lb','EXC_OUT_m51',0);
NewModel=setParam(NewModel,'obj','EXC_OUT_m51',1);

% Initialize loop
mus = [0:0.005:0.4];
SolnArray = cell(size(mus));
FameArray = cell(size(mus));

% Loop through growth rates and get max ethanol
for i = 1:length(mus)
    NewModel=setParam(NewModel,'ub','R_R_BIO',mus(i));
    NewModel=setParam(NewModel,'lb','R_R_BIO',mus(i));
    try
        [SolnArray{i}, FameArray{i}]=solveLPthenPrint(NewModel);
    catch
        break;
        %fprintf('%i \n', i);
    end
end

% Print PhenSpace
PhenSpace = [];
for i = 1:length(mus)
    if cellfun(@isempty,SolnArray(1,i))
        break;
    else
        CB = SolnArray{1,i}.x(787);
        ET = SolnArray{1,i}.x(798);
        CB = CB*12;
        ET = ET*2;
        B = SolnArray{1,i}.x(805);
        point = [ET/CB B];
        PhenSpace(i,:) =  point;
    end
end


end

function NewModel = resetFermParams(model)

NewModel = model;

% CB uptake
NewModel=setParam(NewModel,'ub','EXC_IN_m20',3.5);
NewModel=setParam(NewModel,'lb','EXC_IN_m20',0);

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

