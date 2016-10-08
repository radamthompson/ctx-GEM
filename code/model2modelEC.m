function [ ec_struc ] = model2modelEC( model1,model2, printInfo )
% model2modelEC Map two FBA (GEM) models to each other using E.C. codes
%   This script is designed to take two FBA models with E.C. code reaction
%   distinctions and compare the presence of and thermodynamic constraints
%   of each model.
%
%   model1, model2 := FBA model, can be from COBRA or RAVEN
%   printInfo := Switch to print comparison info to the screen
%           1 = True 
%           0 = False (default)
%
%   ec_struc := MATLAB structure with various fields describing the
%   similarities and differences between the two models
%
%
%
% R. Adam Thompson
% Trinh Lab
% University of Tennessee, Knoxville
% rthomp46@utk.edu
%
% Created: February 24, 2015
% Last edit: May 19, 2015

% Check for printing
if nargin < 3
    printInfo = 0;
end

% Initialize E.C. arrays
% Model 1
if isfield(model1,'eccodes')
    EC1 = model1.eccodes;
elseif isfield(model1,'rxnECNumbers')
    EC1 = model1.rxnECNumbers;
else
    fprintf('Model 1 does not have a field for E.C. numbers\n')
    ec_struc = [];
    return
end

for i=1:length(EC1)
    str = cell2mat(EC1(i));
    str = strsplit(str,'      ');
    [m,n] = size(str);
    [p,q]=size(EC1);
    if n ~= q
        r = n-q;
        fill = cell(p,r);
        EC1 = [EC1 fill];
    end
    for j = 1:n
        strng = strtrim(str(j));
        EC1(i,j) = strng;
    end
end

% Model 2
if isfield(model2,'eccodes')
    EC2 = model2.eccodes;
elseif isfield(model2,'rxnECNumbers')
    EC2 = model2.rxnECNumbers;
else
    fprintf('Model 2 does not have a field for E.C. numbers\n')
    return
end

for i=1:length(EC2)
    str = cell2mat(EC2(i));
    %str = strsplit(str,'      '); %For most RAVEN models
    str = strsplit(str,'/');  % For biocyc import 
    [m,n] = size(str);
    [p,q]=size(EC2);
    if n ~= q
        r = n-q;
        fill = cell(p,r);
        EC2 = [EC2 fill];
    end
    for j = 1:n
        strng = strtrim(str(j));
        EC2(i,j) = strng;
    end
end

% Initialize E.C. linking arrays
[m1,n1] = size(EC1);
[m2,n2] = size(EC2);
EC_link = zeros(max(m1,m2),2);

rxns1 = model1.rxns;
rxns2 = model2.rxns;

% Fix empty cells
for i = 1:n1
    idx = cellfun(@isempty,EC1(:,i));
    EC1(idx,i)=cellstr('');
end
for i = 1:n2
    idx = cellfun(@isempty,EC2(:,i));
    EC2(idx,i)=cellstr('');
end

% Link models
for i = 1:n1
    for j = 1:n2
        [ecnum,idx1,idx2]=intersect(EC1(:,i),EC2(:,j));
        for k = 1:length(idx1)
            if EC_link(idx1(k),1) == 0
                EC_link(idx1(k),1) = idx2(k);
            end
            if EC_link(idx2(k),2) == 0
                EC_link(idx2(k),2) = idx1(k);
            end
        end
    end
end


% Report linkages
ec_struc.model1_link = EC_link(1:m1,1);
ec_struc.model2_link = EC_link(1:m2,2);

% Get thermodynamic constraints
ec_struc = model2modelThermo(model1,model2,ec_struc);


if printInfo == 1
    idx = find(ec_struc.bounds1(:,1));
    mb1 = ec_struc.bounds1(idx,1:2);
    mb2 = ec_struc.bounds1(idx,3:4);
    rxn1 = rxns1(idx);
    rxn2 = ec_struc.model1_link(idx);
    rxn2 = rxns2(rxn2);
    
    fprintf('%15s%15s%15s%15s%15s%15s\n','Model 1 Rxn Name','Bounds','','Model 2 Rxn','Bounds','')
    
    for k = 1:size(idx,1)
        fprintf('%15s%15.5g%15.5g%15s%15.5g%15.5g\n',cell2mat(rxn1(k)),mb1(k,:),cell2mat(rxn2(k)),mb2(k,:))
    end
    fprintf('There are %d differing reactions\n\n',length(idx))
end


end

