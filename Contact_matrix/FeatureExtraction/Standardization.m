function [feature_matrix,sum_matrix]=Standardization(feature_matrix)

sum_matrix=zeros(20,20);
for i=1:20
    for j=1:20
        d=reshape(feature_matrix(i,j,:),1,8);
%         feature_matrix(i,j,:)=mapminmax(d,0,1);
%         feature_matrix(i,j,:)=mapstd(d);
    if sum(d)==0
        feature_matrix(i,j,:)=zeros(1,8);
    else
        feature_matrix(i,j,:)=d/sum(d);
    end
    sum_matrix(i,j)=sum(d);
    end
end
