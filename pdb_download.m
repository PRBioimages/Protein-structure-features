function pdb_download()
% Download the PDB file from https://files.rcsb.org.
list=importdata('.\Dataset\protein_name.xlsx');
for i=1:length(list.textdata)
    disp(list.textdata{i,1});
    url=['https://files.rcsb.org/download/',list.textdata{i,1},'.pdb'];
    filename=['.\Dataset\pdb\',list.textdata{i,1},'.pdb'];
    if exist(filename,'file')
       continue 
    end
    urlwrite(url,filename);
end

