addpath(genpath('.\Contact_matrix'));
addpath(genpath('.\Dihedral_angle_features'));
addpath(genpath('.\Sub_structure_frequency'));
addpath(genpath('.\Chemical_features'));
addpath(genpath('.\Gauss_integrals'));
addpath(genpath('.\Persistent_homology'));
addpath(genpath('.\CNN'));
addpath(genpath('.\GCN'));
addpath(genpath('.\Classifier'));

%% Download pdb files
pdb_download();
%% Contact_matrix
% The obtained features need to be reduced in the SDA folder.
Get_Contact_matrix();
%% Dihedral_angle_features
Get_Dihedral_angle_features();
%% Sub-structure frequency
% After running the code, run .\Sub_structure_frequency\Hierarchical_clustering\main_process.py in python to get the features.
%The author of this part of the code runs in the ubuntu system.
Get_Sub_structure_frequency_features();
%% Chemical features
Get_Chemical_features();
%% Gauss integrals
% The code here is just the sorting of features. 
%The tool that really extracts features is a function of Phaistos, pdb2git, 
%which is introduced in the PDF file given in the folder.
Get_Gauss_integrals();
%% Persistent homology
Get_Persistent_homology_features();
%% CNN
%Using the code in "Prediction of protein function using a deep convolutional neural networkensemble."
%after using its data set to get the pre-trained model,it is used to extract the features of our data set.
%The features obtained by this code need to be used after SDA dimensionality reduction.
%The SDA program is in the Feature folder.
CNN();
%% GCN
%After running the GCN code in matlab, it is only the completion of the GCN data preparation work. 
%You need to run the GCN_train_foldX.py and GCN_test.py files in the GCN folder.
%The author ran this part on ubuntu.
GCN();
%% classification
%The features are placed in the Feature folder. If you want to replace the features for classification,
%please modify it in the corresponding classifier code. It is recommended
%to run each file separately.
SVM();
Random_forest();
Multi_kernel_learning();
