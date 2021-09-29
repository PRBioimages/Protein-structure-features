feature_all=[];
for i=1:116
   path=['.\10\',num2str(i),'.mat'];
   load(path);
   feature_all=[feature_all;feature];
end


for i=1:size(feature_all,2)
    [dataset_scale,ps]=mapminmax(feature_all(:,i)',0,1);
    feature_all(:,i)=dataset_scale';
end

for i=1:116
   feature=feature_all(i,:);
   path=['.\10\',num2str(i),'.mat'];
   save(path,'feature');
end