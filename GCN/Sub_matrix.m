pdb_list=importdata('protein_name.xlsx');
matrix_size=10;
step=5;
pro_num=[];
for k=1:length(pdb_list)
    num=1;
    disp(k);
    file_path=['.\sub_matrix_step5_size10_loc\',num2str(k)];
    mkdir(file_path);
    file_path=['.\sub_matrix_step5_size10\',num2str(k)];
    mkdir(file_path);
    adj_matrix_path=['.\Adjacency_matrix\',num2str(k),'.mat'];
    load(adj_matrix_path);
    length=size(adj_matrix,1);
    submatrix_num=floor(length/5-1);
    for i=1:submatrix_num
        for j=i:submatrix_num
            submatrix=adj_matrix((i-1)*step+1:(i-1)*step+matrix_size,(j-1)*step+1:(j-1)*step+matrix_size);
            if mean(submatrix(:))<10
                file_path=['.\sub_matrix_step5_size10\',num2str(k),'\',num2str(num),'.mat'];
                save(file_path,'submatrix');
                loc=[(i-1)*step+1,(i-1)*step+matrix_size,(j-1)*step+1,(j-1)*step+matrix_size];
                file_path=['.\sub_matrix_step5_size10_loc\',num2str(k),'\',num2str(num),'.mat'];
                save(file_path,'loc');
                num=num+1;
            end
        end
    end
    pro_num=[pro_num;num-1];
end
save('pro_num.mat','pro_num');
