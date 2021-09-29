function Integration1(rootpath)
CNN_feature=[];
for i=1:10
    path=[rootpath,'\',num2str(i),'.mat'];
    load(path);
   if i<=9
      for j=1:27
          CNN_feature=[CNN_feature;Feature_test(j,:)];
      end
   end
   if i==10
      for j=1:32
          CNN_feature=[CNN_feature;Feature_test(j,:)];
      end
   end
end

for i=1:10
    path=[rootpath,'\',num2str(i),'.mat'];
    load(path);
   if i<=9
      for j=28:38

          
          CNN_feature=[CNN_feature;Feature_test(j,:)];
      end
   end
   if i==10
      for j=33:44

          
          CNN_feature=[CNN_feature;Feature_test(j,:)];
      end
   end
end

for i=1:10
    path=[rootpath,'\',num2str(i),'.mat'];
    load(path);
   if i<=9
      for j=39:76

          
          CNN_feature=[CNN_feature;Feature_test(j,:)];
      end
   end
   if i==10
      for j=45:87

          
          CNN_feature=[CNN_feature;Feature_test(j,:)];
      end
   end
end

for i=1:10
    path=[rootpath,'\',num2str(i),'.mat'];
    load(path);
   if i<=9
      for j=77:104

          
          CNN_feature=[CNN_feature;Feature_test(j,:)];
      end
   end
   if i==10
      for j=88:116

          
          CNN_feature=[CNN_feature;Feature_test(j,:)];
      end
   end
end

save('.\Feature\CNN_feature_1000D.mat','CNN_feature');