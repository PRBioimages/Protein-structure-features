# Protein-structure-features
The code is divided into two parts: feature extraction and classification.You need to prepare pdb data before running the program.Pdb data exists in.\Dataset\pdb.

Part 1. Feature extraction

please run main.m. It is recommended to run the program in sections for each feature. You need to download the PDB file before running, please run pdb_download.m. There may be problems with the download due to network problems.

Notice: 

For Sub_structure frequency and GCN, After running the matlab program, you need to run the python program in python.

Sub_structure_frequency: Run .\Sub_structure_frequency\Hierarchical_clustering\main_process.py

GCN: Run GCN_train_foldX.py and GCN_test.py in the GCN folder with python. GCN_train_foldX.py is used to train the model and obtain network classification results, and GCN_test.py is used to to extract network features with the trained model. I ran this part of the code in the ubuntu system. Before running, you need to put the folder Cluster_feature_10_42D and adj in this directory.

Gauss integrals: To install phaistos, please view phaistos_user_manual_1.0.pdf.


Part 2. Classification

Please run the classification section of the main.m file. The selected feature needs to be modified in the code.
