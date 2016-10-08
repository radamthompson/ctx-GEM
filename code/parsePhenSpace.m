function [ out ] = parsePhenSpace( phenSpace, model )
%parsePhenSpace Process output to getPhenotypicSpaces
%   
%   This script will take the output structure from the getPhenotypicSpaces
%   function as an input and return a series of arrays that can be plotted
%   easily. Assumes 5 mmol Glu eq / g DCW / hr.
%
% R. Adam Thompson
% Trinh Lab
% University of Tennessee, Knoxville
% rthomp46@utk.edu
%
% Created: Nov 20, 2015
% Last edit:

n = length(phenSpace);
rxns = model.rxns;

ETHIdx = strcmp(rxns,'EXC_OUT_m51');
IBOHIdx = strcmp(rxns,'EXC_OUT_m109');
H2Idx = strcmp(rxns,'EXC_OUT_m55');
ACEIdx = strcmp(rxns,'EXC_OUT_M52');

eth = phenSpace{1,1}.array';
eth = eth / 5;

h2 = zeros(length(eth),n);
iboh = zeros(size(h2));

for i = 1:n
    h2i = zeros(length(eth),1);
    ibohi = zeros(length(eth),1);
    for j = 1:length(eth)
        h2i(j) = phenSpace{i,1}.h2{j,1}.f;
        ibohi(j) = phenSpace{i,1}.iboh{j,1}.f;    
    end
    h2(:,i) = h2i / 5;
    iboh(:,i) = ibohi / 5;
end

out.eth = eth;
out.h2 = h2;
out.iboh = iboh;

end

