function AminoAcids = getAAfromArray(model, x_array)
%getAAfromArray Pull total amino acid flux for an array of LP solutions
%
% R. Adam Thompson
% Trinh Lab
% University of Tennessee, Knoxville
% rthomp46@utk.edu
%
% Created: July 7, 2015

%Initialize
AaExRxns = {'EXC_BOTH_m31';'EXC_BOTH_m32';'EXC_BOTH_m33';'EXC_BOTH_m34';'EXC_BOTH_m35';'EXC_BOTH_m36';'EXC_BOTH_m37';'EXC_BOTH_m38';'EXC_BOTH_m39';'EXC_BOTH_m40';'EXC_BOTH_m41';'EXC_BOTH_m42';'EXC_BOTH_m43';'EXC_BOTH_m44';'EXC_BOTH_m45';'EXC_BOTH_m46';'EXC_BOTH_m47';'EXC_BOTH_m48';'EXC_BOTH_m49';'EXC_BOTH_m50'};
rxnidx = ones(size(AaExRxns));
AminoAcids = zeros(size(AaExRxns), max(size(x_array)));

% Get indicies
for i = 1:length(AaExRxns)
    idx = find(strcmp(model.rxns,AaExRxns{i}));
    rxnidx(i) = idx;
end
a = 1
% Get AA fluxes
for j = 1:max(size(x_array))
    AminoAcids(:,j) = x_array(rxnidx,j);
end
