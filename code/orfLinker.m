%%
% This script was written to take a series of files from NCBI and connect the ORFs between C. therm DSM 1313 
% and 27405 for downstream bioinformatics analysis
%
% R. Adam Thompson
% Trinh Lab
% University of Tennessee, Knoxville
% rthomp46@utk.edu
%
% Created: Aug 22, 2014
%

% Initialize input files
Cth1313_file = 'Cth1313_CDS_list.txt';      %% From NCBI
Cth27405_file = 'Cth27405_CDS_list.txt';    %% From NCBI
Cth1313_GI_file = 'Cth1313_gi.txt';         %% Text file containing Cth1313_v3_3_2.genes
Cth1313_GB = 'Cth1313.gb';                  %% From NCBI
Cth1313_GP = 'Cth1313.gp';                  %% From NCBI
Cth27405_GB = 'Cth27405.gb';                %% From NCBI

%Initialize for 1313 GI to ORF comparison
locus_tag = '/locus_tag=';
gi_exp = '/db_xref="GI:';

GB_IN = fopen(Cth1313_GB,'r');
lineIn = fgets(GB_IN);

rightORF = false;
orf_array = {};
gi_array = {};
index = 1;

while ischar(lineIn)
    lineIn = strtrim(lineIn);
    check1 = strncmp(locus_tag,lineIn,11);
    check2 = strncmp(gi_exp,lineIn,13);
    % Logic for parsing through CDS ORFs and GI numbers
    if check1 == true && rightORF == true
        if length(lineIn) == 25
        ORF = lineIn(13:24);
        else
            ORF = lineIn(13:25);
        end
        orf_array{index,1} = ORF;
        rightORF = false;
    elseif check1 == true && rightORF == false
        rightORF = true;
    elseif check2 == true
        if size(orf_array,1)-1 == size(gi_array,1)
            GI = lineIn(14:22);
        else
            GI = '';
        end
        gi_array{index,1} = GI;
        index = index+1;
    elseif size(orf_array,1)-2 == size(gi_array,1)
        GI = '';
        gi_array{index,1} = GI;
        index = index+1;
    end
  lineIn = fgets(GB_IN);
end
fclose(GB_IN);

% GP to GI conversion, since there are duplicates in our model
GP_IN = fopen(Cth1313_GP,'r');
gp_array = {};
gi_gp_array = {};
idx = 1;

new_line = fgets(GP_IN)
while ischar(new_line)
    line_parts = strsplit(new_line);
    test = line_parts(1);
    if cell2mat(line_parts(1))=='VERSION'
        gp_array{idx,1} = line_parts(2);
        GI = strtrim(line_parts(3));
        gi_gp_array{idx,1) = GI(4:end);
        idx = idx+1;
    end
    
    
    
    new_line = fgets(GP_IN);
end
fclose(GP_IN);

%Fix indices for gp GI numbers
temp = cell(size(gi_gp_array));
for j = 1:length(gi_gp_array)
    x = length(gi_gp_array);
    temp{j} = gi_gp_array{x-j+1};
end
gi_gp_array = temp;

% Match GI numbers to 1313 ORFs in the same order as
gi_list = Cth1313_v3_3_2.genes;
orf_list = {};
gi_char_array = cell2mat(gi_array);
gi_gp_char_array = cell2mat(gi_gp_array);

for i = 1:length(gi_list)
    GI = num2str(cell2mat(gi_list(i)));
    GI = GI(4:12);  %Extract GI number
    idx = strmatch(GI,gi_char_array);
    if idx == []
        idx = strmatch(GI,gi_gp_char_array);
    end
    ORF = orf_array(idx);
    orf_list{i,1} = ORF;
end
    
