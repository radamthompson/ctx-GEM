function [ SVDstats ] = svdFluxSampling( vs, s_ind, scree_plot )
%svdFluxEnsemble Perform SVD on flux ensemble
%   This function will take a flux ensemble structure and perform 
%   the SVD decomposition of the flux ensemble.
%
%   samples := RAVEN model post optGpSampler w/ loops removed
%   s_ind := substrate index
%	scree_plot := Boolean value, true if you want a Scree plot
%
%   Output:
%   SVDstats := Structure with SVD stats
%
% R. Adam Thompson
% Trinh Lab
% University of Tennessee, Knoxville
% rthomp46@utk.edu
%
% Created: August 8, 2016 
% Last edit: 

% Normalize, mean center, and scale flux-vectors
% vs = real(samples.newpoints);
% vssums = sqrt(sum(vs.^2));
% vs = vs*spdiags(vssums',0,1,1);
% vs = full(vs);

% Normalize to substrate
[m,n] = size(vs);
for i = 1:n
    vs(:,i) = vs(:,i)./vs(s_ind,i);
end

% Perform SVD
[SVDstats.Uv SVDstats.Sv SVDstats.Vv] = svd(vs,'econ');

% Calculate mean to compare to first principal component vector from U
SVDstats.vmean = mean(vs,2);
% Calculate standard deviation for each of the fluxes
SVDstats.vstd = std(vs,0,2);

% Construct scree plot
Sdiag = diag(SVDstats.Sv);
S2 = Sdiag.^2;
S2 = S2/sum(S2);
S2 = cumsum(S2);

if scree_plot == true
figure
plot(S2)
xlabel('Number of principal components')
ylabel('Fraction of cumulative sum of squared singular values')
grid on
xlim([0 10])
end

SVDstats.vs = vs;
SVDstats.S2 = S2;

