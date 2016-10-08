function [ model ] = removeSamplingLoops( model )
%removeSamplingLoops Removes sampling loops
%   Detailed explanation goes here
%
%
% R. Adam Thompson
% Trinh Lab
% University of Tennessee, Knoxville
% rthomp46@utk.edu
%

points = model.points;
[m,n] = size(points);

excId = [832:1:837,839:840,843:1:849,851:1:872]';

newpoints = zeros(size(points));
infeas = [];

for j = 1:n
    newModel = model;
    fluxes = points(excId, j);
    idx = [];
    for k = 1:length(fluxes)
        if fluxes(k) < 1e-4
            idx = [idx k];
        end
    end
    for f = 1:length(fluxes)
        if any(idx==f)
            continue
        elseif fluxes(f) < 0
            newModel = setParam(newModel,'ub',excId(f),fluxes(f)*0.95);
            newModel = setParam(newModel,'lb',excId(f),fluxes(f)*1.05);
        else
            newModel = setParam(newModel,'lb',excId(f),fluxes(f)*0.95);
            newModel = setParam(newModel,'ub',excId(f),fluxes(f)*1.05);
        end
    end
    soln = solveLP(newModel,1);
    try
        newpoints(:,j) = soln.x;
    catch
       infeas = [infeas,j];
    end
end

model.newpoints = newpoints;
model.infeas = infeas;

end
