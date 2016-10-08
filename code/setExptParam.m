function [ newModel ] = setExptParam( model, c_source, expt )
%setExptParam Master parameter setting function for C. therm. GEM
%   Set parameters for many different experimental conditions in one
%   script. Hard coded to be compatible with v10.12 -
%
%   model := RAVEN model
%   c_source := string, 'cb' for cellobiose, 'ce' for cellulose
%   expt := string, experiment descriptor:
%
%                    For Carbon source 'cb':
%            'wt'              Parent strain parameters, MTC bioreactors
%            'hydG'         HydG parameters, MTC bioreactors
%            'he'              hydG ech parameters, MTC bioreactors
%            'hp'              hydG pta parameters, MTC bioreactors
%
%                    For Carbon source 'ce':
%            'high_1'        High substrate loading experiment, phase 1 (early log)
%            'high_2'        High substrate loading, phase 2 (late log)
%            'low_lc'         5 g/L avicel in LC media (Data from Evert Holwerda)
%            'low_mtc'      5 g/L avicel in MTC media (Data from Evert Holwerda)
%
%
%   newModel := Return with new parameters
%
%
% R. Adam Thompson
% Trinh Lab
% University of Tennessee, Knoxville
% rthomp46@utk.edu
%
% Created: Aug 6, 2015
% Last edit: Sept 22, 2015

newModel = clearFermParams(model);

newModel = setCarbonSource(newModel, c_source);

switch expt
    case 'wt'
        newModel = setMedia(newModel,'mtc');
        newModel = setWTparam(newModel);

    case 'hydG'
        newModel = setMedia(newModel,'mtc');
        newModel = setHydGparam(newModel);
    
    case 'he'
        newModel = setMedia(newModel,'mtc');
        newModel = setHydgEchparam(newModel);
    
    case 'hp'
        newModel = setMedia(newModel,'mtc');
        newModel = setHydgPtaparam(newModel);
    
	case 'low_mtc'
        
        newModel = setMedia(newModel,'mtc');
        
        % Data recieved from Evert Holwerda, Dartmouth University
        % Glucose equivalents uptake
        newModel=setParam(newModel,'ub','EXC_IN_m101',6.47);
        newModel=setParam(newModel,'lb','EXC_IN_m101',6.31);
        
        %Putting a cap on urea/ammonia uptake with units of mM N/ gDCW/ hr
        % **Nitrogen upper bound set using high substrate loading paper
        % (Holwerda et al 2014)
%         newModel=setParam(newModel,'ub','EXC_IN_m17',0.69986); %NH3
%         newModel=setParam(newModel,'ub','EXC_IN_m21',1.3997);  % Urea
        
        % Ethanol Production
        newModel=setParam(newModel,'ub','EXC_OUT_m51',2.66);
        newModel=setParam(newModel,'lb','EXC_OUT_m51',2.60);
        
        % Acetate
        newModel=setParam(newModel,'ub','EXC_OUT_m52',3.55);
        newModel=setParam(newModel,'lb','EXC_OUT_m52',3.25);
        
        % Formate
        newModel=setParam(newModel,'ub','EXC_OUT_m53',1.39);
        newModel=setParam(newModel,'lb','EXC_OUT_m53',1.38);
        
        % Lactate
        newModel=setParam(newModel,'ub','EXC_OUT_m54',0.0);
        newModel=setParam(newModel,'lb','EXC_OUT_m54',0.0);
        
    case 'low_lc'
        
        newModel = setMedia(newModel,'lc');
        
        % Data recieved from Evert Holwerda, Dartmouth University
        % Glucose equivalents uptake
        newModel=setParam(newModel,'ub','EXC_IN_m101',6.99);
        newModel=setParam(newModel,'lb','EXC_IN_m101',6.81);
        
        %Putting a cap on urea/ammonia uptake with units of mM N/ gDCW/ hr
        % **Nitrogen upper bound set using high substrate loading paper
        % (Holwerda et al 2014)
%         newModel=setParam(newModel,'ub','EXC_IN_m17',0.69986); %NH3
%         newModel=setParam(newModel,'ub','EXC_IN_m21',1.3997);  % Urea
        
        % Ethanol Production
        newModel=setParam(newModel,'ub','EXC_OUT_m51',2.32);
        newModel=setParam(newModel,'lb','EXC_OUT_m51',2.30);
        
        % Acetate
        newModel=setParam(newModel,'ub','EXC_OUT_m52',5.09);
        newModel=setParam(newModel,'lb','EXC_OUT_m52',4.72);
        
        % Formate
        newModel=setParam(newModel,'ub','EXC_OUT_m53',2.13);
        newModel=setParam(newModel,'lb','EXC_OUT_m53',2.04);
        
        % Lactate
        newModel=setParam(newModel,'ub','EXC_OUT_m54',0.0);
        newModel=setParam(newModel,'lb','EXC_OUT_m54',0.0);
        
end

end

