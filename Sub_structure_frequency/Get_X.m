clear all

load('Cluster_acid.mat');

load('pro_num.mat');

for k=4:4
    distance_weight=k*0.1;
    acid_weight=1-distance_weight;
    file_path=['.\X_',num2str(k)];
    mkdir(file_path);
    for i=1:1052
        X=[];
        Amino_acid=Cluster_acid{i,1};
        for j=1:pro_num(i)
            file_path=['..\..\sub_matrix_step5_size10\',num2str(i),'\',num2str(j),'.mat'];
            load(file_path);
            file_path=['..\..\sub_matrix_step5_size10_loc\',num2str(i),'\',num2str(j),'.mat'];
            load(file_path);
            sub_matrix=submatrix;
            sub_matrix_atom_loc=loc;
            data=get_Features(sub_matrix,sub_matrix_atom_loc,Amino_acid,distance_weight,acid_weight);
            X=[X;data];
        end
        path=['.\X_',num2str(k),'\',num2str(i),'.mat'];
        save(path,'X');
    end
end