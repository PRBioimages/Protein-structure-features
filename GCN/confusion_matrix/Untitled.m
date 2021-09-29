matrix_sum=zeros(4,4);
for i=1:10
   name=[num2str(i),'.mat'];
   load(name);
   matrix_sum=matrix_sum+confusion_matrix;
end
matrix=matrix_sum/10;
save('GCN_network_matrix.mat','matrix');