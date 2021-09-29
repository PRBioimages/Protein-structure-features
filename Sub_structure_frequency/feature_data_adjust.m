clear all

for k=0:10
    distance_weight=k*0.1;
    acid_weight=1-distance_weight;
    file_path=['D:\2021_2_20\off_diagonal_submatrix\Hierarchical_clustering\data_pre\X_',num2str(k)];
    mkdir(file_path);
    for i=1:1904
        disp(i);
        path=['D:\2021_2_20\off_diagonal_submatrix\Hierarchical_clustering\data_pre\X\',num2str(i),'.mat'] ;
        load(path);
        X=[X(:,1:100)/0.33*distance_weight X(:,101:end)/0.67*acid_weight];
        path=['D:\2021_2_20\off_diagonal_submatrix\Hierarchical_clustering\data_pre\X_',num2str(k),'\',num2str(i),'.mat'];
        save(path,'X');
    end
end