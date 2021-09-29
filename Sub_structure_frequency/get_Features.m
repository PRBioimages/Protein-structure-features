function data=get_Features(sub_matrix,sub_matrix_atom_loc,Amino_acid,distance_weight,acid_weight)

% distance data
% distance_weight=0.4;
% acid_weight=0.6;

x=sub_matrix(:);

x=mapminmax(x',0,1);
x=x*distance_weight;

% acid data
symbols = {'ALA', 'ARG', 'ASN', 'ASP', 'CYS', 'GLN', 'MET', ...
    'GLU', 'GLY', 'HIS', 'ILE', 'LEU', 'LYS', 'PHE', ...
    'PRO', 'SER', 'THR', 'TRP', 'TYR', 'VAL'};

if abs(sub_matrix_atom_loc(1,1)-sub_matrix_atom_loc(1,3))>=10
    
    begin1=sub_matrix_atom_loc(1,1);
    finish1=sub_matrix_atom_loc(1,2);
    begin2=sub_matrix_atom_loc(1,3);
    finish2=sub_matrix_atom_loc(1,4);
    Amino_acid=[Amino_acid(begin1:finish1);Amino_acid(begin2:finish2)];
    
else
    
    begin=min(sub_matrix_atom_loc);
    finish=max(sub_matrix_atom_loc);
    Amino_acid=Amino_acid(begin:finish);
    
end

box=zeros(1,length(symbols));

for i=1:length(Amino_acid)
    for j=1:length(symbols)
        if strcmp(Amino_acid{i,1},symbols{1,j})
            box(j)=box(j)+1;
            break;
        end
    end
end

box=box/length(Amino_acid);
box=mapminmax(box,0,1);
box=box*acid_weight;

data=[x,box];