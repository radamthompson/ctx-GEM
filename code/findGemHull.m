function [x, y] = findGemHull(model, product, fig_title)
%findGemHull Plot hull / Phenotypic space of a GEM
%
%	This script takes a COBRA / RAVEN model and a particular product
%	and plots the phenotypic space with respect to cell growth. Script written by
%	modifying Sergio Garcia's getPSpoints.m script.
%	
%	product := variable for product of interest. For iAT601, choices are 'etoh', 
%		'iboh', 'h2', 'lac'.
%	print_fig := boolean for whether or not you want a pdf printed of hull figure
%				default is false
%
% R. Adam Thompson
% Trinh Lab
% University of Tennessee, Knoxville
% rthomp46@utk.edu
%
% Created: Aug 9, 2016
% Last edit: 

% Check if printing figure
if nargin < 3
print_fig = false;
end

% Initialize
nsteps = 100;

[blah, bio_ind] = ismember('EXC_OUT_m86',model.rxns); %cell growth
[blah, s_ind] = ismember('EXC_IN_m101',model.rxns); % glucose equivalents
switch product
	case 'etoh'
	[blah, prod_ind] = ismember('EXC_OUT_m51', model.rxns);
	mol_ratio = 2/6;
	figure_header = 'Phenotypic Space for Ethanol';
	case 'iboh'
	[blah, prod_ind] = ismember('EXC_OUT_m109', model.rxns);
	mol_ratio = 4/6;
	figure_header = 'Phenotypic Space for Isobutanol';
	case 'h2'
	[blah, prod_ind] = ismember('EXC_OUT_m55', model.rxns);
	mol_ratio = 8;
	figure_header = 'Phenotypic Space for Hydrogen';
	case 'lac'
	[blah, prod_ind] = ismember('EXC_OUT_m54', model.rxns);
	mol_ratio = 3/6;
	figure_header = 'Phenotypic Space for Lactate';
	
end

Ymaxprod = zeros(nsteps,1);
Ymaxbio = Ymaxprod;
Yminprod = Ymaxprod;
Yminbio = Ymaxprod;

% Set standard parameters


% Find max cell growth
lp_soln = solveLP(model,1);
max_bio = lp_soln.f*-1;
vbio=linspace(0,max_bio,nsteps)';

% Get the space
model.c(:) = 0;
for i = 1:length(vbio)
	model.lb(bio_ind)=vbio(i);
	model.c(prod_ind) = 1;
	temp_lp = solveLP(model);
	Ymaxprod(i)= mol_ratio*abs(temp_lp.x(prod_ind)/temp_lp.x(s_ind));
	Ymaxbio(i) = temp_lp.x(bio_ind);
	model.c(prod_ind) = -1;
	temp_lp = solveLP(model);
	Yminprod(i) = mol_ratio*abs(temp_lp.x(prod_ind)/temp_lp.x(s_ind));
	Yminbio(i) = temp_lp.x(bio_ind);
end
	
x = [Ymaxbio; Yminbio];
y = [Ymaxprod; Yminprod];

figure
plot(x,y,'g*');
xlabel('\mu (hr^{-1})');
if product == 'h2'
ylabel('Y_{Product/Glu} (mol / mol)');
ylim([0 10]);
xlim([0 1]);
set(gca,'XTick',[0:0.1:1.0],'YTick',[0:0.1:1.0])
else
ylabel('Y_{Product/Glu} (C mol / C mol)');
ylim([0 1]);
xlim([0 1]);
set(gca,'XTick',[0:0.1:1.0],'YTick',[0:0.1:1.0])
end

title(figure_header);

set(gca,'FontSize',14)
set(findall(gcf,'type','text'),'fontSize',16)
fp = fillPage(gcf, 'margins', [0 0 0 0], 'papersize', [8.5 8.5]);

if print_fig == true
    print (gcf,'-dpdf','-r300',fig_title);
end

end	

