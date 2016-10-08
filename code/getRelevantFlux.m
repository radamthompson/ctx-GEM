function [ fluxArray ] = getRelevantFlux( model, LPsoln, rxnList )
%getRelevantFlux Pull flux values of interest from an LP solution
%   Take an LP solution from RAVEN or COBRA, pull out relevant fluxes for
%   the generation of FIgure 2 from Ctherm GEM Manuscript 1.
%
%   LPsoln := LP solution from which to pull fluxes
%   rxns := Cell array of reaction fluxes to pull
%
%   fluxArray := array of fluxes of interest
%
% R. Adam Thompson
% Trinh Lab
% University of Tennessee, Knoxville
% rthomp46@utk.edu
%
% Created: Sep 1, 2015
% Last edit: 

fluxArray = zeros(length(rxnList),1);

rxns = model.rxns;


for i = 1:length(rxnList)
    idx = find(strcmp(rxns,rxnList{i}));
    fluxArray(i) = LPsoln.x(idx);    
end


end

