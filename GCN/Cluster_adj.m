pdb_list=importdata('protein_name.xlsx');
load('pro_num');
for i=1:length(pdb_list)
    pro_coordinates=[];
    num=1;
    disp(i);
    path=['.\coordinates\',num2str(i),'.mat'];
    load(path);
    for j=1:pro_num(i)
        path=['.\sub_matrix_step5_size10_loc\',num2str(i),'\',num2str(j),'.mat'];
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
    path=['.\adj\',num2str(i),'.mat'];
    save(path,'adj_matrix');
end

