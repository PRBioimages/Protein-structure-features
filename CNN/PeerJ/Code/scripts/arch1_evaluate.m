function acc = arch1_evaluate(outpath,k)
%  acc = arch1_evaluate(outpath)
% It merges the features from all Convolution Neural Networks and performs classification 
% using either SVM (linear and rbf) or kNN


netfnames=[{'angles0Dropout0relu1'}, {'angles1Dropout1relu1'}];
% netfnames=[{'angles0Dropout0relu1'}];
iter = 0 ;
retrain = 1; % 0 if you want to use precalculated results

for i=1:length(netfnames) 
    if i==1
        opts.train.numEpochs=100;
    else
        opts.train.numEpochs=50;
    end
    iter = iter +1;
    clear imdb net indtrain indtest

    netfname = netfnames{i};      
    angles = netfname(7); % string = '0' or '1'      
    load(fullfile(outpath, netfname,'options.mat'), 'opts') ;
    load(fullfile(opts.imdbPath,['imdb_' angles '.mat']), 'imdb') ;  
    indtrain = imdb.images.set == 1;
    indtest = imdb.images.set == 3;

    %% Network initialization  
    load(fullfile(opts.train.expDir, ['net-epoch-' num2str(opts.train.numEpochs) '.mat'])); % net, info loaded
    %vl_simplenn_display(net, 'batchSize', opts.train.batchSize) ;
    net.layers{end}.type = 'softmax'; % 'softmax', 'relu', 'sigmoid' % net.layers(end)=[];
    a=imdb.images.data(:,:,:,indtest);
    %% Network evaluate on test data   
%     res_all = vl_simplenn(net, imdb.images.data(:,:,:,:), [], [], 'accumulate', false) ;%提取全部特征的代码
    res_test = vl_simplenn(net, a, [], [], 'accumulate', false) ;
    features_test = double((squeeze(res_test(end).x))'); % [numSamples x 5]
    features_test  = double(features_test);
    
    feature=double((squeeze(res_test(12).x))');
    feature=double(feature);
    
    Y_test = double(imdb.images.labels(indtest))';

    % Fuse features from each network    
    if iter==1, F_test  = features_test; 
    else        F_test  = [F_test  features_test ]; 
    end        
    if iter==1, Feature_test  = feature; 
    else        Feature_test  = [Feature_test  feature]; 
    end        
    %% Network evaluate on train data
    if retrain         
        res_train = vl_simplenn(net, imdb.images.data(:,:,:,indtrain), [], [], 'accumulate', false) ;
        features_train = double((squeeze(res_train(end).x))'); % [numSamples x 4]   
        features_train = double(features_train);
        Y_train = double(imdb.images.labels(indtrain))';

        % Fuse features from each network    
        if iter==1,  F_train = features_train;              
        else         F_train = [F_train features_train];                
        end           
    end


end
path=['.\CNN\PeerJ\Results\1052_1000D\',num2str(k),'.mat'];
save(path,'Feature_test');
save(fullfile(outpath, ['FY_fold' num2str(opts.fold) '_arch1.mat']),'F_train','Y_train','indtrain','Feature_test','Y_test','indtest');

%% Perform classification based on different fusion schemes
disp('************************************************************'); disp(' ');
acc = compareClassifiers(F_train, Y_train, F_test, Y_test,k);
