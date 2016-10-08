function [ FluxSumArr ] = calcFluxSum( model, LPsoln, metList, printInfo, normbool )
%calcFluxSum Calculate metabolite turnover rates within a GEM
%   This script is designed to calculate the Flux Sum of a given list of
%   metabolites following the derivation in Lakshmanan et al, 2015, J Ind
%   Microb Biot, doi:10.1007/s10295-015-1663-0
%
%	model := RAVEN or COBRA model
%	LPsoln := LP solution vector, returned as ans.x from RAVEN's solveLP() or COBRA's optimizeCbModel()
%	metList := Cell array of metabolite names of interest, needs to match
%	model.metNames
%	printInfo := Logical for printing Flux Sums to command window, optional, default = false
%   normbool := Logical for normalizing to substrate uptake rate, optional, default = false
%
%	FluxSumArr := Array of flux sums in the order of metList
%
% R. Adam Thompson
% Trinh Lab
% University of Tennessee, Knoxville
% rthomp46@utk.edu
%
% Created: Aug 21, 2015
% Change Log: 
%   June 10, 2016 - Added normalization option

if nargin < 4
    printInfo = 0;
end
if nargin < 5
    normbool = 0;
end


[Sm Sn] = size(model.S);
S = full(model.S);
FluxSumArr = zeros(length(metList),1);

if normbool
    uprate = LPsoln(759);
    LPsoln = LPsoln./uprate;
end

for i = 1:length(metList)
    idx = strcmp(model.metNames,metList{i});
    idx = find(idx);
    idx = min(idx);
    metRxns = S(idx,:);
    phi = zeros(Sn,1);
    for j = 1:Sn
        phi(j) = abs(metRxns(j)*LPsoln(j));
    end
    fluxSum = 0.5 * sum(phi);
    FluxSumArr(i) = fluxSum;
end

if printInfo
    fprintf('Flux Sums\n')
    for k = 1:length(metList)
    fprintf('%20s \t\t %0.5g\n',metList{k},FluxSumArr(k))
    end
    fprintf(' \n')

end