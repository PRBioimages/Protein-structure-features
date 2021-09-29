% Extract dihedral angle matrix and contact distance matrix
modelfname = '..\Data\pdbmodel_demo.mat'; 
list = '..\Data\list_demo.txt';
ramtrainPerResidue('list',list, 'modelfname', modelfname);