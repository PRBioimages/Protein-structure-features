pdb_list=importdata('protein_name.xlsx');
load('pro_num');
for i=1:length(pdb_list)
    aminoAcids={};
    Cluster_features=[];
    num=1;
    disp(i);
    path=['.\acid_list\',num2str(i),'.mat'];
    load(path);
    for j=1:pro_num(i)
        path=['.\sub_matrix_step5_size10_loc\',num2str(i),'\',num2str(j),'.mat'];
        load(path);
        aminoAcids=[Amino_acid(loc(1):loc(2),:);Amino_acid(loc(3):loc(4),:)]';
        AACfeature=get_AACfeature(aminoAcids,length(aminoAcids));
        Cluster_features=[Cluster_features;AACfeature];
    end
        for j=1:size(Cluster_features,2)
            [dataset_scale,ps]=mapminmax(Cluster_features(:,j)',0,1);
            Cluster_features(:,j)=dataset_scale';
        end
    path=['.\Cluster_feature_10_42D\',num2str(i),'.mat'];
    save(path,'Cluster_features');
end