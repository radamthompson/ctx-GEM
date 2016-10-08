function [means, stds] = calcSamplingMeans(samples)
%calcSamplingMeans Get means and st devs from flux sampling
%   This function takes the result of flux sampling with OptGpSampler and
%   returns a mean and standard deviation for all fluxes in the network
%   which was sampled. This function removes zero vectors which sometimes
%   come up from numerical errors when post-processing the output of
%   OptGpSampler to remove loops.
%
%   samples := Matrix of sampled flux distributions
%
% R. Adam Thompson
% Trinh Lab
% University of Tennessee, Knoxville
% rthomp46@utk.edu
%
% Created: Mar 15, 2016
% Edits: 8/16/2016  AT - Fixing stdev calcs to perform on 32-bit machine
% without running out of RAM

[r, s] = size(samples);

idx = [];

for j = 1:s
    if samples(840,j) == 0 %screen out infeasibles
        idx = [idx j];
    end
end

samples(:,idx) = [];
means = mean(samples,2);
stds = zeros(r,1);
for i = 1:r
    stds(i) = std(samples(i,:));
end


end