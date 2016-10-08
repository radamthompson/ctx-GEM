function [ new_model, link_struc ] = checkRxnStoich( model1, model2, walk_through, print_to_excel, excel_file, excel_sheet )
%checkRxnStoich Compares two GEMs by reaction to find differently declared rxns
%   When troublshooting a GEM structure, it may be convenient to compare
%   the declared stoichiometry of reactions to a template model which is
%   known to work effectively. This script compares two models reaction by
%   reaction (linked via E.C. numbers) then tells you which ones are
%   differently declared as far as reaction stoichiometry is concerned. You
%   have the option to spit all the different reactions to an excel file,
%   walk through them individually and change the reactions with RAVEN.
%
%   model1 := the model you care about editing
%   model2 := the template model
%   walk_through := operator for reaction by reaction walkthrough to edit
%   stoichiometry, 1 is yes, 0 (default) is no
%   print_to_excel := operator for excel output, 1 is yes please print, 0
%   (default) is no
%   excel_file := string of excel filename
%   excel_sheet := string of excel sheet to write to
%
%   new_model := new RAVEN model structure
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
% Created: May 23, 2015
% Last edit:
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Set up defaults
if nargin < 3
    walk_through = 0;
end

if nargin < 4
    print_to_excel = 0;
end

if nargin < 5 && print_to_excel ~= 0
    input_file = 'Give a name for the excel output file: \n';
    excel_file = input(input_file,'s');
    excel_sheet = 'Sheet1';
end



% Initialize
rxns1 = model1.rxns;
rxns2 = model2.rxns;
new_model = rmfield(model1,{'grRules','rxnGeneMat'});

count = 1;

if print_to_excel == 1
    headers = {'Model 1 Name','Model 1 Rxn','Model 2 Rxn','Model 2 Name'};
    xlswrite(excel_file,headers,excel_sheet,'A2');
end

% Link models
link_struc = model2modelEC(model1,model2,0);

idx = find(link_struc.model1_link(:,1));
mb1 = link_struc.bounds1(idx,1:2);
mb2 = link_struc.bounds1(idx,3:4);
rxn1 = rxns1(idx);
rxn2 = link_struc.model1_link(idx);
rxn2 = rxns2(rxn2);

% Begin working loop of linked reactions
for i = 1:length(idx)
    % Get reaction in each model
    rm1 = idx(i);
    rm2 = link_struc.model1_link(rm1);
    
    % Get metabolites involved
    [met1,id,val1] = find(model1.S(:,rm1));
    [met2,id,val2] = find(model2.S(:,rm2));
    
    % Sum substrates and products
    p1 = sum(val1(find(val1>0)));
    p2 = sum(val2(find(val2>0)));
    
    s1 = sum(val1(find(val1<0)));
    s2 = sum(val2(find(val2<0)));
    
    % Check if reactions are declared differently
    if p1 ~= p2 || s1 ~= s2
        
        % Get reactions as text
        eq1=constructEquations(model1,rm1,false);
        eq2=constructEquations(model2,rm2,false);
        
        % Print the reactions to excel
        if print_to_excel == 1
            rn1 = model1.rxns(rm1);
            rn2 = model2.rxns(rm2);
            xlswrite(excel_file,rn1,excel_sheet,strcat('A',num2str(count+2)));
            xlswrite(excel_file,eq1,excel_sheet,strcat('B',num2str(count+2)));
            xlswrite(excel_file,eq2, excel_sheet,strcat('C',num2str(count+2)));
            xlswrite(excel_file,rn2, excel_sheet,strcat('D',num2str(count+2)));
        end
        
        % Go through walk through
        if walk_through == 1
            fprintf('\n%9s%10s%8s%8s\n','Model 1: ',cell2mat(rxn1(idx(i))),num2str(mb1(idx(i),1)),num2str(mb1(i,2)))
            fprintf('%s\n',cell2mat(eq1))
            fprintf('\n%9s%10s%8s%8s\n','Model 2: ',cell2mat(rxn2(idx(i))),num2str(mb2(idx(i),1)),num2str(mb2(i,2)))
            fprintf('%s\n\n',cell2mat(eq2))
            
            chngRxn = 'Would you like to change the reaction stoichiometry? (Y/N)   ';
            result = input(chngRxn,'s');
            switch result
                case {'Y','y'}
                    % Request new reaction definition for model 1
                    get_rxn = 'Enter new reaction definition for model 1:  ';
                    rxn_eqn = input(get_rxn,'s');
                    try
                        new_model = changeRxns(new_model,rxn1(idx(i)),rxn_eqn,2,'c',true);
                    catch
                        fprintf('Stopped at i = %i\n', i)
                        warning('Error with changeRxns. Ending this script')
                        break
                    end
                    
                otherwise
                    fprintf('Fair enough\n')
            end
            bal = length(idx)-i;
            fprintf('Only %i reactions left to check \n',bal)
            
        end
        count = count+1;
    end
    
    
end

new_model.grRules = model1.grRules;
new_model.rxnGeneMat = model1.rxnGeneMat;

end


