function [ x_array, MuSurface, AASurface ] = generate3wayATP( model, figName )
%generate3wayATP Compare ATP for cellulosome and biomass vs growth rate
%   This script will take a model and run a series of calculations designed
%   to compare the ATP requirements of biomass and the cellulosome on the
%   growth rate.
%	
%	If figName is not provided, a pdf of the plot will not be created
%
% R. Adam Thompson
% Trinh Lab
% University of Tennessee, Knoxville
% rthomp46@utk.edu
%
% Created: Aug 6, 2015
% Last edit: Dec 14, 2015

if nargin < 2
    printFig = 0;
else
    printFig = 1;
end

% Initialize loop
GAMArray = [0:1:50];
CellArray = [50:1:100];

SolnArray = cell(size(GAMArray));
FameArray = cell(size(GAMArray));
%AaArray = cell(size(GAMArray));
MuSurface = zeros(length(GAMArray),length(CellArray));
AASurface = zeros(length(GAMArray),length(CellArray));

BIOidx = strcmp(model.rxns,'EXC_OUT_m86');
newModel=setParam(model,'obj','EXC_OUT_m86',1);

max_count = length(GAMArray)*length(CellArray);
x_array = zeros(length(model.rxns),max_count);

count = 0;
% Loop through ATP and Cellulosome arrays
for i = 1:length(GAMArray)
    gam = GAMArray(i);
    equation = sprintf('%1.3f H2O + %1.3f ATP + Cell Dry Weight no GAM => %1.3f ADP + %1.3f Orthophosphate + Biomass',gam,gam,gam,gam);
    equation = {equation};
    newModel = changeRxns(newModel,'R_R_BIO',equation,2,'C_c',false);
    
    for j = 1:length(CellArray)
        cel = CellArray(j);
        equation = sprintf('%1.3f H2O + %1.3f ATP + 0.4317 L-Glutamate + 0.6373 Glycine + 0.5581 L-Alanine + 0.441 L-Lysine + 0.5523 L-Aspartate + 0.2365 L-Arginine + 0.1871 L-Glutamine + 0.4942 L-Serine + 0.1469 L-Methionine + 0.1718 L-Tryptophan + 0.2851 L-Phenylalanine + 0.3235 L-Tyrosine + 0.0665 L-Cysteine + 0.5329 L-Leucine + 0.1099 L-Histidine + 0.4823 L-Proline + 0.5523 L-Asparagine + 0.506 L-Valine + 0.5572 L-Threonine + 0.4739 L-Isoleucine => %1.3f ADP + %1.3f Orthophosphate + Cellulosome term',cel,cel,cel,cel);
        equation = {equation};
        newModel = changeRxns(newModel,'R_R_Cellulosome',equation,2,'C_c',false);
        
        try
            soln = solveLP(newModel,1);
           % soln =optimizeCbModel(newModel,'max',0,false);
            count = count + 1;
        catch
            soln.stat = -1;
            count = count + 1;
            x_array(:,count) = zeros(length(model.rxns),1);
        end
        if soln.stat == -1
            MuSurface(i,j) = 0;
            AASurface(i,j) = 0;
            x_array(:,count) = zeros(length(model.rxns),1);
        else
            AaArray = getAminoAcids(newModel, soln);
            x_array(:,count) = soln.x;
            AminoAcids = sum(AaArray);
            Mu = soln.x(BIOidx);
            MuSurface(i,j) =Mu;
            AASurface(i,j) =AminoAcids;
            
        end
    end
    a = 1;
end

figure
surf(CellArray,GAMArray,MuSurface)

ylabel('GAM ATP Req.');
xlabel('Cellulosome ATP Req.');
zlabel('Specific growth rate \mu (hr^{-1})');
ylim([0 50]);
xlim([50 100]);
zlim([0 0.5]);
set(gca,'Ydir','reverse')

a = findobj(gcf);
allaxes=findall(a,'Type','axes');
alllines=findall(a,'Type','line');
alltext=findall(a,'Type','text');

set(alltext,'fontSize',18);
set(allaxes,'linewidth',1,'fontsize',16);
set(alllines,'linewidth',1);
fp = fillPage(gcf, 'margins', [0 0 0 0], 'papersize', [8.5 8.5]);

if printFig == 1
    print (gcf,'-dpdf','-r300',figName);
end

end


function AminoAcids = getAminoAcids(model, soln)
%getAminoAcids Pull total amino acid flux for a LP solution

%Initialize
AaExRxns = {'EXC_BOTH_m31';'EXC_BOTH_m32';'EXC_BOTH_m33';'EXC_BOTH_m34';'EXC_BOTH_m35';'EXC_BOTH_m36';'EXC_BOTH_m37';'EXC_BOTH_m38';'EXC_BOTH_m39';'EXC_BOTH_m40';'EXC_BOTH_m41';'EXC_BOTH_m42';'EXC_BOTH_m43';'EXC_BOTH_m44';'EXC_BOTH_m45';'EXC_BOTH_m46';'EXC_BOTH_m47';'EXC_BOTH_m48';'EXC_BOTH_m49';'EXC_BOTH_m50'};
rxnidx = ones(size(AaExRxns));
AminoAcids = zeros(size(AaExRxns));

% Get indicies
for i = 1:length(AaExRxns)
    idx = find(strcmp(model.rxns,AaExRxns{i}));
    rxnidx(i) = idx;
end

% Get AA fluxes
AminoAcids = soln.x(rxnidx);



end