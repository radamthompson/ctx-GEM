function [ newModel ] = setMedia( model, recipe )
%setMedia Define media recipe for C therm for C therm
%   This script takes a C therm GEM and sets either cellobiose or cellulose
%   for a carbon source. This script works for version 10.11 onwards with
%   an active cellulosome reaction
%
%   model := RAVEN model
%   recipe := string designating media recipe:
%                     'lc'        LC media (Holwerda et al, 2012)
%                     'mtc'       MTC media (Thompson et al, 2015)
%                     'mnm'     MNM media (Kridelbaugh et al, 2013)
%                     'ctfud'     Complex media, take up everything
%
% R. Adam Thompson
% Trinh Lab
% University of Tennessee, Knoxville
% rthomp46@utk.edu
%
% Created: Aug 5, 2015
% Last edit: Sep 9,2015

newModel = model;

switch recipe
    case 'mtc'
        newModel = setMinimal(newModel);
        
        % CB uptake just to have a somewhat reasonable default
        newModel=setParam(newModel,'ub','EXC_IN_m20',5);
        newModel=setParam(newModel,'lb','EXC_IN_m20',0);
        
        %Sulfur sources
        newModel=setParam(newModel,'ub','EXC_IN_m25',1000); %SO4
        newModel=setParam(newModel,'lb','EXC_IN_m25',0);
        
        newModel=setParam(newModel,'ub','EXC_IN_m29',0); %H2S
        newModel=setParam(newModel,'lb','EXC_IN_m29',0);
        
        newModel=setParam(newModel,'ub','EXC_BOTH_m35',1000); %Cysteine, uptake value is kind of arbitrary
        newModel=setParam(newModel,'lb','EXC_BOTH_m35',-0.5);
        
        % Nitrogen
%         newModel=setParam(newModel,'ub','EXC_IN_m17',1.5); %NH3
%         newModel=setParam(newModel,'ub','EXC_IN_m21',1.5);  % Urea
        
        %Extra vitamins
        %         newModel=setParam(newModel,'ub','EXC_IN_m28',0); % Pantothenate
        %         newModel=setParam(newModel,'lb','EXC_IN_m28',0);
        %
        %         newModel=setParam(newModel,'ub','EXC_IN_m30',1000); % Nicotinamide
        %         newModel=setParam(newModel,'lb','EXC_IN_m30',0);
        
    case 'lc'
        newModel = setMinimal(newModel);
        
        %Sulfur sources
        newModel=setParam(newModel,'ub','EXC_IN_m25',0); %SO4
        newModel=setParam(newModel,'lb','EXC_IN_m25',0);
        
        newModel=setParam(newModel,'ub','EXC_IN_m29',0); %H2S
        newModel=setParam(newModel,'lb','EXC_IN_m29',0);
        
        newModel=setParam(newModel,'ub','EXC_BOTH_m35',1000); %Cysteine, set at 10 fold less than MTC value for media differences, also rather arbitrary
        newModel=setParam(newModel,'lb','EXC_BOTH_m35',-0.5);
        
        newModel=setParam(newModel,'ub','EXC_IN_m21',0);  % Urea
        
    case 'mnm'
        newModel = setMinimal(newModel);
        
        %Sulfur sources
        newModel=setParam(newModel,'ub','EXC_IN_m25',0); %SO4
        newModel=setParam(newModel,'lb','EXC_IN_m25',0);
        
        newModel=setParam(newModel,'ub','EXC_IN_m29',1000); %H2S
        newModel=setParam(newModel,'lb','EXC_IN_m29',0);
        
        newModel=setParam(newModel,'ub','EXC_BOTH_m35',0);
        newModel=setParam(newModel,'lb','EXC_BOTH_m35',0);
        
        newModel=setParam(newModel,'ub','EXC_IN_m17',0);  % NH4
        
    case 'ctfud'
        %Sulfur sources
        newModel=setParam(newModel,'ub','EXC_IN_m25',1000); %SO4
        newModel=setParam(newModel,'lb','EXC_IN_m25',0);
        
        newModel=setParam(newModel,'ub','EXC_IN_m29',1000); %H2S
        newModel=setParam(newModel,'lb','EXC_IN_m29',0);
        %Extra vitamins
        newModel=setParam(newModel,'ub','EXC_IN_m28',1000); % Pantothenate
        newModel=setParam(newModel,'lb','EXC_IN_m28',0);
        
        newModel=setParam(newModel,'ub','EXC_IN_m30',1000); % Nicotinamide
        newModel=setParam(newModel,'lb','EXC_IN_m30',0);
        
        % Amino Acids - arbitrary uptake rates, probably too high
        newModel=setParam(newModel,'lb','EXC_BOTH_m31',-10); %Ala
        newModel=setParam(newModel,'lb','EXC_BOTH_m32',-10); %Arg
        newModel=setParam(newModel,'lb','EXC_BOTH_m33',-10); %Asp
        newModel=setParam(newModel,'lb','EXC_BOTH_m34',-10); %Asn
        newModel=setParam(newModel,'lb','EXC_BOTH_m35',-10); %Cys
        newModel=setParam(newModel,'lb','EXC_BOTH_m36',-10); %Glu
        newModel=setParam(newModel,'lb','EXC_BOTH_m37',-10); %Gln
        newModel=setParam(newModel,'lb','EXC_BOTH_m38',-10); %Gly
        newModel=setParam(newModel,'lb','EXC_BOTH_m39',-10); %His
        newModel=setParam(newModel,'lb','EXC_BOTH_m40',-10); %Iso
        newModel=setParam(newModel,'lb','EXC_BOTH_m41',-10); %Leu
        newModel=setParam(newModel,'lb','EXC_BOTH_m42',-10); %Lys
        newModel=setParam(newModel,'lb','EXC_BOTH_m43',-10); %Met
        newModel=setParam(newModel,'lb','EXC_BOTH_m44',-10); %Phe
        newModel=setParam(newModel,'lb','EXC_BOTH_m45',-10); %Pro
        newModel=setParam(newModel,'lb','EXC_BOTH_m46',-10); %Ser
        newModel=setParam(newModel,'lb','EXC_BOTH_m47',-10); %Thr
        newModel=setParam(newModel,'lb','EXC_BOTH_m48',-10); %Trp
        newModel=setParam(newModel,'lb','EXC_BOTH_m49',-10); %Tyr
        newModel=setParam(newModel,'lb','EXC_BOTH_m50',-10); %Val
end


end

function newModel = setMinimal(model)

% Set amino acid uptake to zero
newModel = model;

newModel=setParam(newModel,'lb','EXC_BOTH_m31',0); %Ala
newModel=setParam(newModel,'lb','EXC_BOTH_m32',0); %Arg
newModel=setParam(newModel,'lb','EXC_BOTH_m33',0); %Asp
newModel=setParam(newModel,'lb','EXC_BOTH_m34',0); %Asn
newModel=setParam(newModel,'lb','EXC_BOTH_m35',0); %Cys
newModel=setParam(newModel,'lb','EXC_BOTH_m36',0); %Glu
newModel=setParam(newModel,'lb','EXC_BOTH_m37',0); %Gln
newModel=setParam(newModel,'lb','EXC_BOTH_m38',0); %Gly
newModel=setParam(newModel,'lb','EXC_BOTH_m39',0); %His
newModel=setParam(newModel,'lb','EXC_BOTH_m40',0); %Iso
newModel=setParam(newModel,'lb','EXC_BOTH_m41',0); %Leu
newModel=setParam(newModel,'lb','EXC_BOTH_m42',0); %Lys
newModel=setParam(newModel,'lb','EXC_BOTH_m43',0); %Met
newModel=setParam(newModel,'lb','EXC_BOTH_m44',0); %Phe
newModel=setParam(newModel,'lb','EXC_BOTH_m45',0); %Pro
newModel=setParam(newModel,'lb','EXC_BOTH_m46',0); %Ser
newModel=setParam(newModel,'lb','EXC_BOTH_m47',0); %Thr
newModel=setParam(newModel,'lb','EXC_BOTH_m48',0); %Trp
newModel=setParam(newModel,'lb','EXC_BOTH_m49',0); %Tyr
newModel=setParam(newModel,'lb','EXC_BOTH_m50',0); %Val

end