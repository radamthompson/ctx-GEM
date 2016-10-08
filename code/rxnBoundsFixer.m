function [ new_model1,link_struc ] = rxnBoundsFixer( model1,model2 )
%rxnBoundsFixer Walk through two models, comparing reactions with different
%thermodynamic constraints
%   This function takes 2 FBA models and finds common reactions between the
%   models based on E.C. numbers, compares the thermodynamic constraints
%   between the models, and allows the user to change reaction bounds
%   efficiently.
%
%   model1, model2 := FBA model, can be from COBRA or RAVEN
%
%   link_struc := MATLAB structure with various fields describing the
%   similarities and differences between the two models
%
%
%
% R. Adam Thompson
% Trinh Lab
% University of Tennessee, Knoxville
% rthomp46@utk.edu
%
% Created: February 26, 2015
% Last edit: May 21, 2015
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Get model reaction mapping
link_struc = model2modelEC(model1,model2,0);

% Initialize
rxns1 = model1.rxns;
rxns2 = model2.rxns;
new_model1 = model1;

idx = find(link_struc.model1_link(:,1));
mb1 = link_struc.bounds1(idx,1:2);
mb2 = link_struc.bounds1(idx,3:4);
rxn1 = rxns1(idx);
rxn2 = link_struc.model1_link(idx);
rxn2 = rxns2(rxn2);

%
for i = 1:length(idx)
    % Print the reactions in each model
    rm1 = idx(i);
    rm2 = link_struc.model1_link(rm1);
    eq1=constructEquations(model1,rm1,false);
    eq2=constructEquations(model2,rm2,false);
    fprintf('\n%9s%10s%8s%8s\n','Model 1: ',cell2mat(rxn1(i)),num2str(mb1(i,1)),num2str(mb1(i,2)))
    fprintf('%s\n',cell2mat(eq1))
    fprintf('\n%9s%10s%8s%8s\n','Model 2: ',cell2mat(rxn2(i)),num2str(mb2(i,1)),num2str(mb2(i,2)))
    fprintf('%s\n\n',cell2mat(eq2))
    
    chngBound = 'Would you like to alter the reaction bounds? (Y/N)   ';
    result = input(chngBound,'s');
    switch result
        case {'Y','y'}
            % Request new bounds for model 1
            newUB = 'Enter new upper bound for model 1:  ';
            UB = input(newUB);
            if ~isfloat(UB)
                fprintf('Please enter an integer\n')
                UB = input(newUB);
            end
            newLB = 'Enter new lower bound for model 1:  ';
            LB = input(newLB);
            if ~isfloat(LB)
                fprintf('Please enter an integer\n')
                LB = input(newLB);
            end
            try
                % Call setParam
                new_model1 = setParam(new_model1,'ub',rm1,UB);
            catch
                warning('Upper bound is incorrect. Ending script')
                break
            end
            try
                new_model1 = setParam(new_model1,'lb',rm1,LB);
            catch
                warning('Lower bound is incorrect. Ending script')
                break
            end
            
        otherwise
            fprintf('Fair enough\n')
    end
    bal = length(idx)-i;
    fprintf('Only %i reactions left to check \n',bal)
end

end
