pdb_list=importdata('protein_name.xlsx');
num=1;
for i=1:length(pdb_list)
    disp(i);
    path=['..\Dataset\pdb\',pdb_list{i,1},'.pdb'];
    pdb_file=pdbread(path);
    [adj_matrix, Amino_acid, coordinates]=Adjacency(pdb_file);
    adj_matrix=adj_matrix+adj_matrix';
    name=['.\Adjacency_matrix\',num2str(num),'.mat'];
    name2=['.\acid_list\',num2str(num),'.mat'];
    save(name,'adj_matrix');
    save(name2,'Amino_acid');
    name3=['.\coordinates\',num2str(num),'.mat'];
    save(name3,'coordinates');
    num=num+1;
end
