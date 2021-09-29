function Multi_kernel_learning()

currentFolder = pwd;
addpath(genpath(currentFolder))

for k=1:10
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
    name1=['.\Feature\Backup\SDA\deepLocSDA\feature_SDA',num2str(k),'.mat']; % Add sequence features
    load(name1);
    for i=1:size(E,2)
        [dataset_scale,ps]=mapminmax(E(:,i)',0,1);
        E(:,i)=dataset_scale';
    end
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
    train1Labels=Y_train;
    test1Labels=Y_test;
    train1data=X_train;
    test1data=X_test;
    
    y=zeros(1087,1);
    for i=1:1087
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
    
    load('.\Feature\Backup\Sub_structure_frequency.mat');
    load('.\Feature\Backup\Dihedral_angle_features.mat');
    load('.\Feature\Backup\Chemical_features.mat');
    load('.\Feature\Backup\Persistent_homology_features.mat');
    load('.\Feature\Backup\hummplocfeature.mat');
    load('.\Feature\Backup\Gauss_integral_features.mat');
    load('.\Feature\Backup\GCN_feature.mat');
    E=[Gauss_integral_features Sub_structure_frequency Chemical_features];
    % Add structure features
    %Contact_matrix
    %Dihedral_angle_features
    %Sub_structure_frequency
    %Chemical_features
    %Gauss_integral_features
    %Persistent_homology_features
    %CNN_feature
    %GCN_feature

    for i=1:size(E,2)
        [dataset_scale,ps]=mapminmax(E(:,i)',0,1);
        E(:,i)=dataset_scale';
    end
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
    train2Labels=Y_train;
    test2Labels=Y_test;
    train2data=X_train;
    test2data=X_test;
    
    
%     [train1_data,test1_data] = featnorm(train1data,test1data);
%     train1_data = double(train1_data*2-1);
%     test1_data = double(test1_data*2-1);
%     [train2_data,test2_data] = featnorm(train2data,test2data);
%     train2_data = double(train2_data*2-1);
%     test2_data = double(test2_data*2-1);
    testmaxacc=0;
    testmaxF1score=0;
    for m=0.1:0.1:2.0
        for n=0.1:0.1:2.0  %0.9:0.1:2.1
            gamma=[m,n];
            %             base_params.gamma=gamma;
            
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%S-PSorter%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
            tic
            %train
            %             idx_sda=MyClassifparams.idx_sda;
            %             gamma=MyClassifparams.gamma;
            %
            kfold=5;
            parak='-t 4';
            %             Yt=ones(size(data,1),1);
            %             beta=classifier.result.beta;
            %             model=classifier.result.model;
            traindataHaralick=train1data;
            traindataLBP=train2data;
            testdataHaralick=test1data;
            testdataLBP=test2data;
            MK=[];
            gnd=train1Labels;
            MK(:,:,1)=calckernel('rbf',gamma(1),traindataHaralick);
            MK(:,:,2)=calckernel('rbf',gamma(2),traindataLBP);
            sw.result=jb_2gridSearch(MK,gnd,kfold);
            %             test
            beta=sw.result.beta;
            model=sw.result.model;
            parak='-t 4';
            
            
            Haralick=[traindataHaralick;testdataHaralick];
            LBP=[traindataLBP;testdataLBP];
            trLab=[1:size(traindataHaralick,1)]';
            teLab=[size(traindataHaralick,1)+1:size(traindataHaralick,1)+size(testdataHaralick,1)]';
            allK=[];
            %             allK(:,:,1)=calckernel('rbf',gamma(1),Haralick);
            %             allK(:,:,2)=calckernel('rbf',gamma(2),LBP);
            allK(:,:,1)=calckernel('rbf',gamma(1),Haralick);
            allK(:,:,2)=calckernel('rbf',gamma(2),LBP);
            K=allK(trLab,trLab,:);
            KT=allK(teLab,trLab,:);
            tK=K(:,:,1)*beta(1);
            tKT=KT(:,:,1)*beta(1);
            for ii=2:length(beta)
                tK=tK+K(:,:,ii)*beta(ii);
                tKT=tKT+KT(:,:,ii)*beta(ii);
            end
            Yt=test2Labels';
            [pred_label,accuracy,p] = svmpredict(double(Yt), double([(1:length(Yt))', tKT]), model);%model
            a=zeros(4,4);
            for i=1:length(Yt)
                a(Yt(i),pred_label(i))=a(Yt(i),pred_label(i))+1;
            end
            F1_score=zeros(1,4);
            for i=1:4
                if a(i,i)==0
                    F1_score(i)=0;
                    continue
                end
                p=a(i,i)/(sum(a(:,i)));
                r=a(i,i)/(sum(a(i,:)));
                F1_score(i)=2*(p*r)/(p+r);
            end
            F1_ave=sum(F1_score(1,:))/4;
            
            if F1_ave>testmaxF1score%accuracy(1)>testmaxacc
                acc(k)=accuracy(1);
                testmaxacc=accuracy(1);
                testmaxF1score=F1_ave;
                final_beta{k}=beta;
                final_model{k}=model;
                final_gamma{k}=gamma;
                final_confusion{k}=a;
            end
        end
    end
end

ACC_and_F1=cal_confusion(final_confusion);
disp(ACC_and_F1);