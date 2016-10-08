function fArray = checkRxnContribution(model)
%checkRxnContribution See how setting each flux to 0 influences LP solution
%   This script takes a RAVEN model and sees how the flux distribution
%   changes when an individual reaction flux is set to 0, then repeats this
%   iteratively for every reaction in the network.
%
%   Future version will make histgram of fractional flux changes..
%
%   model := RAVEN model
%
%   fArray := Array of length( reactions ) with LP objective f values
%
% R. Adam Thompson
% Trinh Lab
% University of Tennessee, Knoxville
% rthomp46@utk.edu
%
% Created: May 21, 2015
% Last edit: Aug 6, 2015

[m,n] = size(model.S);
lb = model.lb;
ub = model.ub;

fArray = zeros(n,1);
% for each reaction in S
for i = 1:n
    % set bounds to 0,0
    model = setParam(model,'ub',i,0);
    model = setParam(model,'lb',i,0);
    % solveLP
    ans = solveLP(model);
    % report LP solution
    try
        fArray(i) = ans.f;
    catch
        fArray(i) = 0;
    end
end

