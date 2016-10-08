function [ output ] = performSVDforSamples( model, samples, print )
%performSVDforSamples Take sample of flux distributions and perform SVD
%   This function takes in a set of sampled flux distributions and performs
%   an SVD for flux discrepancy calculations
%
%   print == 1 if you want to output a Scree plot
%
% R. Adam Thompson
% Trinh Lab
% University of Tennessee, Knoxville
% rthomp46@utk.edu
%
% Created: Feb 26, 2016
% Last edit:

mat = samples;
[m,n] = size(mat);

GEid = 832; % Glucose equivalents

%Normalize to Glu Eq uptake
for i = 1:n
    vec = mat(:,i);
    vec = vec./vec(GEid);
    mat(:,i) = vec;
end

b = []; % Remove NaN vectors
for i = 1:n
    a = isnan(mat(1,i));
    if a == 1
        b = [b i];
    end
end
mat(:,b) = [];

[V.Uv V.Sv V.Vv] = svd(mat);

output.vmean = mean(mat,2);
output.vstd = std(mat,0,2);

if print == 1 %Scree plot
    Sdiag = diag(V.Sv);
    S2 = Sdiag.^2;
    S2 = S2/sum(S2);
    S2 = cumsum(S2);
    figure
    plot(S2)
    xlabel('Number of principal components')
    ylabel('Fraction of cumulative sum of squared singular values')
    grid on
    xlim([0 10])
end

output.full = samples;
output.mat = mat;
output.svd = V;


end

