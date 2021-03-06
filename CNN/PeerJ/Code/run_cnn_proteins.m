function opts = run_cnn_proteins(modelfname,fold,arch,k)
% Experiment with the cnn_proteins

%% Using imdb_0.mat (contact maps) 
[net, opts] = cnn_proteins(modelfname,fold,k,arch,'angles', false, 'Dropout', false, 'relu', true); 
close all

%% Using imdb_1.mat (angles) 
[net, opts] = cnn_proteins(modelfname,fold,k,arch,'angles', true, 'Dropout', true, 'relu', true); 
close all

% end
