function [ mean_arr, std_arr, mu_arr ] = parseFluxSamples( soln_cells, remove_loops )
%parseFluxSamples Calc stats for cell array of flux samples
%   This function takes a cell array of flux sampling outputs and returns
%   the mean and std dev of each flux distribution into a set of arrays
%   which can be plotted.
%
%   Works for discreteFBA cell arrays
%
%   soln_cells := cell array of outputs from sampling procedure where each
%   cell component is a model structure with the constraints used in the
%   sampling as well as the warmup points and sample points returned by
%   OptGpSampler
%
%       Optional Inputs:
%   remove_loops := boolean as to if loops need to be removed, default is
%   yes ( remove_loops = 1 )
%
%   mean_arr := array of means for each reaction within network sampled
%   std_arr := array of std devs
%   mu_arr := array of mus used as constraints in the sample for easy
%   plotting
%
% R. Adam Thompson
% Trinh Lab
% University of Tennessee, Knoxville
% rthomp46@utk.edu
%
% Created: Mar 15, 2016
% Last edit:

s = length(soln_cells);
try
    r = length(soln_cells.c);
catch
    r = length(soln_cells{1,3}.c);
end

mean_arr = zeros(r,s);
std_arr = zeros(r,s);
mu_arr = zeros(1,s);

% Removing Loops
if remove_loops == 1
    excId = [817:1:827,832:1:872];  %All transport out except CO2 and specific sugars (not Glu Eq)
    
    parfor i = 1:length(soln_cells)
        soln_cells{1,i} = parParse(soln_cells{1,i},excId);
        fprintf('Finished set %i\n',i)
    end
end

% Calc Stats
for i = 1:s
    if isfield(soln_cells{1,i},'newpoints')
        [means, stds] = calcSamplingMeans(soln_cells{1,i}.newpoints);
        mean_arr(:,i) = means;
        std_arr(:,i) = stds;
        mu_arr(i) = means(840);
    end
end

end

