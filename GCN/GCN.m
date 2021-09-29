function GCN()

pdb_list=importdata('.\GCN\protein_name.xlsx');
num=1;
for i=1:length(pdb_list)
    disp(i);
    path=['.\Dataset\pdb\',pdb_list{i,1},'.pdb'];
    pdb_file=pdbread(path);
    [adj_matrix, Amino_acid, coordinates]=Adjacency(pdb_file);
    adj_matrix=adj_matrix+adj_matrix';
    name=['.\GCN\Adjacency_matrix\',num2str(num),'.mat'];
    name2=['.\GCN\acid_list\',num2str(num),'.mat'];
    save(name,'adj_matrix');
    save(name2,'Amino_acid');
    name3=['.\GCN\coordinates\',num2str(num),'.mat'];
    save(name3,'coordinates');
    num=num+1;
end


matrix_size=10;
step=5;
pro_num=[];
for k=1:length(pdb_list)
    num=1;
    disp(k);
    file_path=['.\GCN\sub_matrix_step5_size10_loc\',num2str(k)];
    mkdir(file_path);
    file_path=['.\GCN\sub_matrix_step5_size10\',num2str(k)];
    mkdir(file_path);
    adj_matrix_path=['.\GCN\Adjacency_matrix\',num2str(k),'.mat'];
    load(adj_matrix_path);
    submatrix_num=floor(size(adj_matrix,1)/5-1);
    for i=1:submatrix_num
        for j=i:submatrix_num
            submatrix=adj_matrix((i-1)*step+1:(i-1)*step+matrix_size,(j-1)*step+1:(j-1)*step+matrix_size);
            if mean(submatrix(:))<10
                file_path=['.\GCN\sub_matrix_step5_size10\',num2str(k),'\',num2str(num),'.mat'];
                save(file_path,'submatrix');
                loc=[(i-1)*step+1,(i-1)*step+matrix_size,(j-1)*step+1,(j-1)*step+matrix_size];
                file_path=['.\GCN\sub_matrix_step5_size10_loc\',num2str(k),'\',num2str(num),'.mat'];
                save(file_path,'loc');
                num=num+1;
            end
        end
    end
    pro_num=[pro_num;num-1];
end
save('.\GCN\pro_num.mat','pro_num');

load('pro_num');
for i=1:length(pdb_list)
    pro_coordinates=[];
    num=1;
    disp(i);
    path=['.\GCN\coordinates\',num2str(i),'.mat'];
    load(path);
    for j=1:pro_num(i)
        path=['.\GCN\sub_matrix_step5_size10_loc\',num2str(i),'\',num2str(j),'.mat'];
        load(path);
        coordinates_center=mean([coordinates(loc(1):loc(2),:);coordinates(loc(3):loc(4),:)]);
        pro_coordinates=[pro_coordinates;coordinates_center];
    end
    
    if size(pro_coordinates,1)>1
        adj_matrix=zeros(size(pro_coordinates,1),size(pro_coordinates,1));
        for centeratoms=1:size(pro_coordinates,1)
            for relativeatoms=centeratoms:size(pro_coordinates,1)
%                 adj_matrix(centeratoms,relativeatoms)=norm(pro_coordinates(relativeatoms,:)-pro_coordinates(centeratoms,:));
                if norm(pro_coordinates(relativeatoms,:)-pro_coordinates(centeratoms,:))<=10
                    adj_matrix(centeratoms,relativeatoms)=1;
                end
            end
        end
        adj_matrix=adj_matrix+adj_matrix';
    else
        adj_matrix=[];
    end
    adj_matrix=adj_matrix-diag(diag(adj_matrix));
    path=['.\GCN\adj\',num2str(i),'.mat'];
    save(path,'adj_matrix');
end


for i=1:length(pdb_list)
    aminoAcids={};
    Cluster_features=[];
    num=1;
    disp(i);
    path=['.\GCN\acid_list\',num2str(i),'.mat'];
    load(path);
    for j=1:pro_num(i)
        path=['.\GCN\sub_matrix_step5_size10_loc\',num2str(i),'\',num2str(j),'.mat'];
        load(path);
        aminoAcids=[Amino_acid(loc(1):loc(2),:);Amino_acid(loc(3):loc(4),:)]';
        AACfeature=get_AACfeature(aminoAcids,length(aminoAcids));
        Cluster_features=[Cluster_features;AACfeature];
    end
        for j=1:size(Cluster_features,2)
            [dataset_scale,ps]=mapminmax(Cluster_features(:,j)',0,1);
            Cluster_features(:,j)=dataset_scale';
        end
    path=['.\GCN\Cluster_feature_10_42D\',num2str(i),'.mat'];
    save(path,'Cluster_features');
end
