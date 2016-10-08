function [ yields ] = parseLandscape( landscape, model )
%parseLandscape Parse through exploration landscape
%
%   This function will parse through an output from
%   'exploreEnergyBalance.m'. Assumes 5 mmol / gDCW / hr glucose uptake.
%
%   yields := structure of values to be plotted elsewhere
%
% R. Adam Thompson
% Trinh Lab
% University of Tennessee, Knoxville
% rthomp46@utk.edu
%
% Created: Nov 19, 2015
% Last edit:

n = length(landscape);
rxns = model.rxns;

ETHIdx = strcmp(rxns,'EXC_OUT_m51');
IBOHIdx = strcmp(rxns,'EXC_OUT_m109');
H2Idx = strcmp(rxns,'EXC_OUT_m55');
ACEIdx = strcmp(rxns,'EXC_OUT_m52');


mu = zeros(n,1);
eth = zeros(n,1);
h2 = zeros(n,1);
iboh = zeros(n,1);
ace = zeros(n,1);
ols = zeros(n,2); % [eth iboh]
all = zeros(n,3); % [eth iboh h2]

% Calc. yields (mol P / mol gluc)
for i = 1:n
    lsc = landscape{i};
    if lsc.mu.stat == 1
        mu(i) = lsc.mu.f;
    end
    if lsc.eth.stat == 1
        eth(i) = lsc.eth.f/5;
    end
    if lsc.ace.stat ==1
        ace(i) = lsc.ace.f/5;
    end
    if lsc.h2.stat == 1
        h2(i) = lsc.h2.f/5;
    end
    if lsc.iboh.stat ==1
        iboh(i) = lsc.iboh.f/5;
    end
    if lsc.ols.stat == 1
        ols(i,:) = [lsc.ols.x(ETHIdx)/5 lsc.ols.x(IBOHIdx)/5];
    else
        ols(i,:) = [0 0];
    end
    if lsc.all.stat == 1
        all(i,:) = [lsc.all.x(ETHIdx)/5 lsc.all.x(IBOHIdx)/5 lsc.all.x(H2Idx)/5];
    else
        all(i,:) = [0 0 0];
    end
end

yields.mu = mu;
yields.eth = eth;
yields.ace = ace;
yields.h2 = h2;
yields.iboh = iboh;
yields.ols = ols;
yields.all = all;
