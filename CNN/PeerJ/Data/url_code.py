import numpy as np
import pandas as pd
import  urllib.request
pdb_name = pd.read_table('list_peerj_nolabel2.txt',header = None)
length=len(pdb_name)
print ("downloading with urllib.request")
for i in range(593,len(pdb_name)):
    print(i)
    pro_name=pdb_name.iloc[i,0]
    url = 'https://files.rcsb.org/download/'+pro_name+'.pdb'
    try:
        f = urllib.request.urlopen(url) 
        data = f.read()
        path='D:\\2020_10_30\\PeerJ\\Data\pdb2\\'+pro_name+'.pdb'
        with open(path, "wb") as code: 
            code.write(data)
    except:
        with open("error2.txt", "a") as code: 
            code.write(pro_name)
            code.write('\r\n')
