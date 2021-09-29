clear all;
GCN_feature=[];
for i=1:10
   if i<=9
      for j=1:27
          path=['.\GCN\feature\',num2str(i),'\',num2str(j),'.mat'];
          load(path);
          GCN_feature=[GCN_feature;feature];
      end
   end
   if i==10
      for j=1:32
          path=['.\GCN\feature\',num2str(i),'\',num2str(j),'.mat'];
          load(path);
          GCN_feature=[GCN_feature;feature];
      end
   end
end

for i=1:10
   if i<=9
      for j=28:38
          path=['.\GCN\feature\',num2str(i),'\',num2str(j),'.mat'];
          load(path);
          GCN_feature=[GCN_feature;feature];
      end
   end
   if i==10
      for j=33:44
          path=['.\GCN\feature\',num2str(i),'\',num2str(j),'.mat'];
          load(path);
          GCN_feature=[GCN_feature;feature];
      end
   end
end

for i=1:10
   if i<=9
      for j=39:76
          path=['.\GCN\feature\',num2str(i),'\',num2str(j),'.mat'];
          load(path);
          GCN_feature=[GCN_feature;feature];
      end
   end
   if i==10
      for j=45:87
          path=['.\GCN\feature\',num2str(i),'\',num2str(j),'.mat'];
          load(path);
          GCN_feature=[GCN_feature;feature];
      end
   end
end

for i=1:10
   if i<=9
      for j=77:104
          path=['.\GCN\feature\',num2str(i),'\',num2str(j),'.mat'];
          load(path);
          GCN_feature=[GCN_feature;feature];
      end
   end
   if i==10
      for j=88:116
          path=['.\GCN\feature\',num2str(i),'\',num2str(j),'.mat'];
          load(path);
          GCN_feature=[GCN_feature;feature];
      end
   end
end

save('GCN_feature.mat','GCN_feature');