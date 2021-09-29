clear all
% load('..\2DCNN_feature.mat');
% E=[Feature_test];

load('D:\2020_10_30\PeerJ\Results\1052_1000D\CNN_feature.mat');
E=[CNN_feature];
% load('D:\2020_7_3\Multi-core_learning\1277\deeploc\deeploc_feature.mat');
matrix=E;
for j=1:10
%    name=['D:\2020_7_3\HPA\code\SDA\sdalog\',feature_name,'\sdalog',num2str(j),'.txt'];
    name=['.\sdalog\sdalog',num2str(j),'.txt'];
    data=importdata(name);
    E=[];
    for i=1:length(data.textdata)
%         if strfind(data.textdata{i,5},'<')==1
        if str2double(data.textdata{i,4})>2
            a=str2double(data.textdata{i,2})-1;
            if isnan(a)==1
                a=str2double(data.textdata{i,3})-1;
            end
            E=[E matrix(:,a)];
        end
    end
    name1=['.\CNN_featureSDA_v2\feature_SDA',num2str(j),'.mat'];
    save(name1,'E');
end