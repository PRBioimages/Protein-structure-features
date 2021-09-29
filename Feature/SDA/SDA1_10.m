clear all
load('..\CNN_feature.mat');
E=[CNN_feature];
%contact1 contact2 contact3 contact4 contact5 contact6 contact7 contact8
%angle_feature
%Hierarchical_clustering_feature
%surface_atom_feature
%GITfeature
%own_barcodefeature
%CNN_feature
%deepLocfeature
%hummplocfeature

        
% for i=1:size(E,2)
%     [dataset_scale,ps]=mapminmax(E(:,i)',0,1);
%     E(:,i)=dataset_scale';
% end
y=zeros(1052,1);
for i=1:1052
    if i>=1&&i<=275
        y(i)=1;
    end
    if i>=276&&i<=386
        y(i)=2;
    end
    if i>=387&&i<=771
        y(i)=3;
    end
    if i>=772&&i<=1052
        y(i)=4;
    end
end

for k=1:10
    X_train=[];
    Y_train=[];
    % Y_train=[];
    X_test=[];
    Y_test=[];
    if k==1
        num=1;
        for j=1:1052
            if (j>=1&&j<=27)||(j>=276&&j<=286)||(j>=387&&j<=424)||(j>=772&&j<=799)
                X_test(num,:)=E(j,:);
                Y_test(num)=y(j);
                num=num+1;
            end
        end
        
        num=1;
        for j=1:1052
            if (j>=28&&j<=275)||(j>=287&&j<=386)||(j>=425&&j<=771)||(j>=800&&j<=1052)
                X_train(num,:)=E(j,:);
                Y_train(num)=y(j);
                num=num+1;
            end
        end
    end
    
    
    if k>=2&&k<=9
        num=1;
        for j=1:1052
            if (j>=28+(k-2)*27&&j<=54+(k-2)*27)||(j>=287+(k-2)*11&&j<=297+(k-2)*11)||(j>=425+(k-2)*38&&j<=462+(k-2)*38)||(j>=800+(k-2)*28&&j<=827+(k-2)*28)
                X_test(num,:)=E(j,:);
                Y_test(num)=y(j);
                num=num+1;
            end
        end
        num=1;
        for j=1:1052
            if (j>=1&&j<=27+(k-2)*27)||(j>=276&&j<=286+(k-2)*11)||(j>=387&&j<=424+(k-2)*38)||(j>=772&&j<=799+(k-2)*28)
                X_train(num,:)=E(j,:);
                Y_train(num)=y(j);
                num=num+1;
            end
        end
        for j=1:1052
            if (j>=55+(k-2)*27&&j<=275)||(j>=298+(k-2)*11&&j<=386)||(j>=463+(k-2)*38&&j<=771)||(j>=828+(k-2)*28&&j<=1052)
                X_train(num,:)=E(j,:);
                Y_train(num)=y(j);
                num=num+1;
            end
        end
    end
    
    if k==10
        num=1;
        for j=1:1052
            if (j>=244&&j<=275)||(j>=375&&j<=386)||(j>=729&&j<=771)||(j>=1024&&j<=1052)
                X_test(num,:)=E(j,:);
                Y_test(num)=y(j);
                num=num+1;
            end
        end
        num=1;
        for j=1:1052
            if (j>=1&&j<=243)||(j>=276&&j<=374)||(j>=387&&j<=728)||(j>=772&&j<=1023)
                X_train(num,:)=E(j,:);
                Y_train(num)=y(j);
                num=num+1;
            end
        end
    end
    
    Y_test=Y_test';
    Y_train=Y_train';
    [traindata,testdata]=featnorm(X_train,X_test);
    traindata=double(traindata*2-1);
    testdata=double(testdata*2-1);
    
    u=unique(Y_train);
    %feat=[];
    feat{length(u)}=[];
    for i=1:length(u)
        feat{i}=traindata(Y_train==u(i),:);
    end
    logfilename=['.\sdalog\sdalog',num2str(k),'.txt'];
    idx_sda=ml_stepdisc(feat,logfilename);
end
