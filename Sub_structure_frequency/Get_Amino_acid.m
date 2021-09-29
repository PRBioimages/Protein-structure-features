function Amino_acid=Get_Amino_acid(str_final)
pdb_file=pdbread(str_final);
Amino_acid={};
CA_order=1;
for i=1:length(pdb_file.Model(1).Atom)
    if CA_order==1
        if strcmp(pdb_file.Model(1).Atom(i).AtomName,'CA')==1
            Amino_acid=[Amino_acid;pdb_file.Model(1).Atom(i).resName];
        end
    else
        if strcmp(pdb_file.Model(1).Atom(i).AtomName,'CA')==1
            Amino_acid=[Amino_acid;pdb_file.Model(1).Atom(i).resName];
        end
    end
end

