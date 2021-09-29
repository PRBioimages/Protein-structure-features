import scipy.io as sio
import numpy as np


def indexofMin(arr,size):
    minindex = 0
    currentindex = 1
    while currentindex < size:
        if arr[0,currentindex] < arr[0,minindex]:
            minindex = currentindex
        currentindex += 1
    return minindex

def Get_feature(t1,t2,data_number):
    
    num_data = sio.loadmat('pro_num.mat')
    
    
    pro_num=num_data['pro_num']
    pro_num=pro_num-1
    
    path='./Representative_submatrix/Second_Representative_submatrix.npy'
    Second_Representative_submatrix=np.load(path)
    feature= np.empty(shape=[0, len(Second_Representative_submatrix)])
    for i in range(1052):
        print(i+1)
        per_feature=np.zeros((1,len(Second_Representative_submatrix)))
        path='./data_pre/X_'+str(data_number)+'/'+str(i+1)+'.mat'
        matrix=sio.loadmat(path)
        submatrix=matrix['X']
        for j in range(pro_num[i,0]):
            x=submatrix[j].flatten()
            symbols=np.zeros((1,len(Second_Representative_submatrix)))
            for k in range(len(Second_Representative_submatrix)):
                symbols[0,k] = np.linalg.norm(x-Second_Representative_submatrix[k])
            location = indexofMin(symbols,len(Second_Representative_submatrix))
            per_feature[0,location]=per_feature[0,location]+1
        per_feature=per_feature/pro_num[i,0]
        feature=np.vstack((feature,per_feature))
    
    path='Sub_structure_frequency_'+str(t1)+'_'+str(t2)+'.mat'
    sio.savemat(path, {'feature':feature})


