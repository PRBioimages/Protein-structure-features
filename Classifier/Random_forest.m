function Random_forest()
load('.\Feature\Backup\Sub_structure_frequency.mat');
load('.\Feature\Backup\Dihedral_angle_features.mat');
load('.\Feature\Backup\Chemical_features.mat');
load('.\Feature\Backup\Persistent_homology_features.mat');
load('.\Feature\Backup\hummplocfeature.mat');
load('.\Feature\Backup\Gauss_integral_features.mat');
load('.\Feature\Backup\GCN_feature.mat');

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

ntree_result=[];
all_confusion_matrix={};
for ntree=1:10
    confusion_matrix=zeros(4,4);
    disp(ntree);
    ntree=ntree*50;
    ntree_result_10=[];
    for m=1:1
        k_result=[];
        matrix=zeros(4,4);
        for k=1:10
            disp(k);
            name=['.\Feature\Backup\SDA\CNN_featureSDA\feature_SDA',num2str(k),'.mat'];
            load(name);
            CNN_feature=E;
            
            name=['.\Feature\Backup\SDA\contact_feature\1\feature_SDA',num2str(k),'.mat'];
            load(name);
            contact1=E;
            
            name=['.\Feature\Backup\SDA\contact_feature\2\feature_SDA',num2str(k),'.mat'];
            load(name);
            contact2=E;
            
            name=['.\Feature\Backup\SDA\contact_feature\3\feature_SDA',num2str(k),'.mat'];
            load(name);
            contact3=E;
            
            name=['.\Feature\Backup\SDA\contact_feature\4\feature_SDA',num2str(k),'.mat'];
            load(name);
            contact4=E;
            
            name=['.\Feature\Backup\SDA\contact_feature\5\feature_SDA',num2str(k),'.mat'];
            load(name);
            contact5=E;
            
            name=['.\Feature\Backup\SDA\contact_feature\6\feature_SDA',num2str(k),'.mat'];
            load(name);
            contact6=E;
            
            name=['.\Feature\Backup\SDA\contact_feature\7\feature_SDA',num2str(k),'.mat'];
            load(name);
            contact7=E;
            
            name=['.\Feature\Backup\SDA\contact_feature\8\feature_SDA',num2str(k),'.mat'];
            load(name);
            contact8=E;
            Contact_matrix=[contact1 contact2 contact3 contact4 contact5 contact6 contact7 contact8];
            name=['.\Feature\Backup\SDA\deepLocSDA\feature_SDA',num2str(k),'.mat'];
            load(name);
            deepLoc_feature=E;
            E=[Sub_structure_frequency Chemical_features Gauss_integral_features];
            %Add one or more protein features for RF classification, the
            %feature list is as follows:
            %Contact_matrix
            %Dihedral_angle_features
            %Sub_structure_frequency
            %Chemical_features
            %Gauss_integral_features
            %Persistent_homology_features
            %CNN_feature
            %GCN_feature
            %deepLoc_feature
            %hummplocfeature
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
            
            
            
            model = classRF_train(X_train,Y_train,ntree);
            test_options.predict_all = 1;
            [Y_hat, votes, prediction_pre_tree] = classRF_predict(X_test,model,test_options);
            
            for i=1:size(votes,2)
                [dataset_scale,ps]=mapminmax(votes(:,i)',0,1);
                votes(:,i)=dataset_scale';
            end
            
            vote_label=[];
            for i=1:length(votes)
                vector=votes(i,:);
                [max_value,max_loc]=max(vector);
                vote_label=[vote_label;max_loc];
            end
            num=0;
            for i=1:length(Y_test)
                if vote_label(i)==Y_test(i)
                    num=num+1;
                end
            end
            acc_vote=num/length(Y_test);
            
            a=zeros(4,4);
            
            for i=1:length(Y_test)
                a(Y_test(i),vote_label(i))=a(Y_test(i),vote_label(i))+1;
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
            acc=sum(diag(a))/sum(a(:));
            F1_ave=sum(F1_score(1,:))/4;
            k_result=[k_result;[acc F1_ave]];
            matrix=matrix+a;
        end
        ntree_result_10=[ntree_result_10;[ntree mean(k_result(:,1))*100 mean(k_result(:,2))]];
        confusion_matrix=confusion_matrix+matrix/10;
    end
    ntree_result=[ntree_result;ntree_result_10];
    all_confusion_matrix=[all_confusion_matrix;confusion_matrix];
end
disp(ntree_result);
% save('.\result\GCN+GIT+Hierarchical_clustering.mat','ntree_result');
% save('.\confusion_matrix\GCN+GIT+Hierarchical_clustering.mat','all_confusion_matrix');

