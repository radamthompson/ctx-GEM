function [ thermo_struc ] = model2modelThermo( model1, model2, ec_struc )
% model2modelThermo Use E.C. code map to
%   This script was written to work within model2modelEC as a
%   Thermodynamics constraint parser between the two models
%
%   model1, model2 := FBA model, can be from COBRA or RAVEN
%   ec_struc := structure from model2modelEC function
%
%   thermo_struc := MATLAB structure with fields comparing thermodynamic
%   constraints of similar reactions between models
%
%
%
% R. Adam Thompson
% Trinh Lab
% University of Tennessee, Knoxville
% rthomp46@utk.edu
%
% Created: February 24, 2015
% Last edit: Feb. 26, 2015

% Initialize
lb1 = model1.lb;
ub1 = model1.ub;

lb2 = model2.lb;
ub2 = model2.ub;

link_m1 = ec_struc.model1_link;
link_m2 = ec_struc.model2_link;

thermo_struc = ec_struc;

m1 = length(lb1);
m2 = length(lb2);

bounds_m1 = zeros(1,2);
bounds_m2 = zeros(1,2);

checks1 = zeros(m1,4);
checks2 = zeros(m2,4);

% Get bounds
for i=1:length(lb1)
    bounds_m1 = [lb1(i) ub1(i)];
    if link_m1(i) ~= 0
        bounds_m2 = [lb2(link_m1(i)) ub2(link_m1(i))];
    else
        bounds_m2 = [lb1(i) ub1(i)]; % Dummy replacement
    end
    % Compare bounds
    if ~isequal(bounds_m1,bounds_m2)
        checks2(link_m1(i),:) = [bounds_m2 bounds_m1];
    end
end

for i=1:length(lb2)
    bounds_m2 = [lb2(i) ub2(i)];
    if link_m2(i) ~= 0
        bounds_m1 = [lb1(link_m2(i)) ub1(link_m2(i))];
    else
        bounds_m1 = [lb2(i) ub2(i)]; % Dummy replacement
    end
    % Compare bounds
    if ~isequal(bounds_m1,bounds_m2)
        checks1(link_m2(i),:) = [bounds_m1 bounds_m2];
    end
end


thermo_struc.bounds1 = checks1;
thermo_struc.bounds2 = checks2;



end

