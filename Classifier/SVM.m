function SVM()
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
F1_final=0;

for q=1:50
%     for g=0:0.01:1    g,c grid search
%     for c=0:0.5:40
    confusion_matrix=zeros(4,4);
    acc=zeros(10,2);
    number=1;
    
    g=unifrnd (0,1);
    c=unifrnd (0,40);
    for k=1:10
        name=['.\Feature\Backup\SDA\deepLocSDA\feature_SDA',num2str(k),'.mat'];
        load(name);
        deepLocfeature=E;
        
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

        E=[Sub_structure_frequency Chemical_features Gauss_integral_features];
        
        %Add one or more protein features for SVM classification, the
        %feature list is as follows:
        %Contact_matrix
        %Dihedral_angle_features
        %Sub_structure_frequency
        %Chemical_features
        %Gauss_integral_features
        %Persistent_homology_features
        %CNN_feature
        %GCN_feature
        %deepLocfeature
        %hummplocfeature

        
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
        
        Y_test=Y_test';
        Y_train=Y_train';
        
        
        %         [mtrain,ntrain]=size(X_train);
        %         [mtest,ntest]=size(X_test);
        %         dataset=[X_train;X_test];
        %         [dataset_scale,ps]=mapminmax(dataset',0,1);
        %         dataset_scale=dataset_scale';
        %         X_train=dataset_scale(1:mtrain,:);
        %         X_test=dataset_scale((mtrain+1):(mtrain+mtest),:);
        
        
        param=['-g ',num2str(g),' -c ',num2str(c),'-s 0 -t 2'];
        model=svmtrain(Y_train,X_train,param); %#ok<SVMTRAIN>
        [iris_predict_label,iris_accuracy,dec_values]=svmpredict(Y_test,X_test,model);
        a=zeros(4,4);
        
        for i=1:length(Y_test)
            a(Y_test(i),iris_predict_label(i))=a(Y_test(i),iris_predict_label(i))+1;
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
        confusion_matrix=confusion_matrix+a;
        acc(number,1)=iris_accuracy(1);
        acc(number,2)=F1_ave;
        number=number+1;
    end
    disp('.................')
    disp(mean(acc(1:10,1)));
    disp(mean(acc(1:10,2)));
    if (mean(acc(1:10,2))>F1_final)%&&(iris_accuracy(1)>acc_final)
        g_final=g;
        c_final=c;
        a_final=confusion_matrix/10;
        acc_final=acc;
        F1_final=mean(acc(1:10,2));
    end
%     end
%     end
end
disp(g_final);
disp(c_final);
result=[mean(acc_final(1:10,1)) mean(acc_final(1:10,2))]
% save('.\confusion_matrix\H+S.mat','a_final');