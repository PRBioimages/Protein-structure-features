function Get_Sub_structure_frequency_features()

% Get the distance matrix of the protein

num=1;
str2='.pdb';
pdb_list=importdata('.\Dataset\protein_name.xlsx');
for i=1:length(pdb_list.textdata) %length(pdb_list.textdata.Sheet1)
    disp(i);
    str1=lower(pdb_list.textdata{i,1});%str1=lower(pdb_list.textdata.Sheet1{i,1});
    str=strcat(str1,str2);
    str_final=strcat('.\Dataset\pdb\',str);
    pdb_file=pdbread(str_final);
    [adj_matrix,~]=Adjacency(pdb_file);
    adj_matrix=adj_matrix+adj_matrix';
    name=['.\Sub_structure_frequency\adj_matrix\',num2str(num),'.mat'];
    save(name,'adj_matrix');
    num=num+1;
end

% Get the Sub-matrices of proteins
matrix_size=10;
step=5;
pro_num=[];
for k=1:1052
    num=1;
    disp(k);
    file_path=['.\Sub_structure_frequency\sub_matrix_step5_size10_loc\',num2str(k)];
    mkdir(file_path);
    file_path=['.\Sub_structure_frequency\sub_matrix_step5_size10\',num2str(k)];
    mkdir(file_path);
    adj_matrix_path=['.\Sub_structure_frequency\adj_matrix\',num2str(k),'.mat'];
    load(adj_matrix_path);
    
    adj_length=size(adj_matrix,1);
    submatrix_num=floor(adj_length/5-1);
    for i=1:submatrix_num
        for j=1:submatrix_num
            submatrix=adj_matrix((i-1)*step+1:(i-1)*step+matrix_size,(j-1)*step+1:(j-1)*step+matrix_size);
            if mean(submatrix(:))<15
                file_path=['.\Sub_structure_frequency\sub_matrix_step5_size10\',num2str(k),'\',num2str(num),'.mat'];
                save(file_path,'submatrix');
                loc=[(i-1)*step+1,(i-1)*step+matrix_size,(j-1)*step+1,(j-1)*step+matrix_size];
                file_path=['.\Sub_structure_frequency\sub_matrix_step5_size10_loc\',num2str(k),'\',num2str(num),'.mat'];
                save(file_path,'loc');
                num=num+1;
            end
        end
    end
    pro_num=[pro_num;num];
end
save('.\Sub_structure_frequency\Hierarchical_clustering\pro_num.mat','pro_num');



load('.\Sub_structure_frequency\Hierarchical_clustering\pro_num.mat');
%Get the features of the substructure
pdb_list=importdata('.\Dataset\protein_name.xlsx');
str2='.pdb';
for k=4:4
    distance_weight=k*0.1;
    acid_weight=1-distance_weight;
    file_path=['.\Sub_structure_frequency\Hierarchical_clustering\data_pre\X_',num2str(k)];
    mkdir(file_path);
    for i=1:1052
        disp(i);
        str1=lower(pdb_list.textdata{i,1});
        str=strcat(str1,str2);
        str1='.\Dataset\pdb\';
        str_final=strcat(str1,str);
        Amino_acid=Get_Amino_acid(str_final);
        X=[];
        for j=1:pro_num(i)
            file_path=['.\Sub_structure_frequency\sub_matrix_step5_size10\',num2str(i),'\',num2str(j),'.mat'];
            load(file_path);
            file_path=['.\Sub_structure_frequency\sub_matrix_step5_size10_loc\',num2str(i),'\',num2str(j),'.mat'];
            load(file_path);
            sub_matrix=submatrix;
            sub_matrix_atom_loc=loc;
            data=get_Features(sub_matrix,sub_matrix_atom_loc,Amino_acid,distance_weight,acid_weight);
            X=[X;data];
        end
        path=['.\Sub_structure_frequency\Hierarchical_clustering\data_pre\X_',num2str(k),'\',num2str(i),'.mat'];
        save(path,'X');
    end
end