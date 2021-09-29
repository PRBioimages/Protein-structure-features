matrix_sum=zeros(4,4);
for i=1:10
   name=[num2str(i),'.mat'];
   load(name);
   matrix_sum=matrix_sum+a;
end
matrix=matrix_sum/10;
save('CNN_network_matrix.mat','matrix');