num=1;
str2='.pdb';
pdb_list=importdata('..\Dataset\protein_name.xlsx');
for i=1:length(pdb_list.textdata) %length(pdb_list.textdata.Sheet1)
    disp(i);
    str1=lower(pdb_list.textdata{i,1});%str1=lower(pdb_list.textdata.Sheet1{i,1});
    str=strcat(str1,str2);
    str_final=strcat('..\Dataset\pdb\',str);
    pdb_file=pdbread(str_final);
    [adj_matrix Amino_acid]=Adjacency(pdb_file);
    adj_matrix=adj_matrix+adj_matrix';
    name=['.\adj_matrix\',num2str(num),'.mat'];
    save(name,'adj_matrix');
    num=num+1;
end
