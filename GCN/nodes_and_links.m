Nodes_number=0;
Links_number=0;
for i=1:1052
path=['.\adj\',num2str(i),'.mat'];
load(path);
Nodes_number=Nodes_number+size(adj_matrix,1);
Links_number=Links_number+sum(adj_matrix(:))/2;
end
mean_Nodes_number=Nodes_number/1052;
mean_Links_number=Links_number/1052;