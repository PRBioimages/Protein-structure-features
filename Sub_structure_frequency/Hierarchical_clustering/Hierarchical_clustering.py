import scipy.io as sio
import numpy as np
import scipy
import scipy.cluster.hierarchy as sch
from scipy.cluster.vq import vq, kmeans, whiten
import matplotlib.pyplot as plt
import time
from numpy import *
from mpl_toolkits.mplot3d import Axes3D
from sklearn import manifold, datasets

def frist_Hierarchical(t_value,data_number):
    

    graph_type=2  #1:2D 2:3D
    
    num_data = sio.loadmat('pro_num.mat')
    
    
    pro_num=num_data['pro_num']
    pro_num=pro_num-1
    
    
    for i in range(1052):
        path='./data_pre/X_'+str(data_number)+'/'+str(i+1)+'.mat'
        matrix=sio.loadmat(path)    
        submatrix=matrix['X']        
        data=[]
        for j in range(pro_num[i,0]):
            data.append(submatrix[j]);
        
        A=[]
        for j in range(len(submatrix)):
            A.append(j+1)
    
        if len(A)==1:
            Representative_submatrix=data[0]
        else:
            t0 = time.time()  
            Z = sch.linkage(data, method='ward')
            f = sch.fcluster(Z, t=t_value, criterion='distance')  # t value
            Hierarchical_time = time.time() - t0
            print ("time:%.4fs" % Hierarchical_time)
            print(f)  #打印类标签
        
        # t-SNE
    #        X=data
            y=f
            
    
    #        tsne = manifold.TSNE(n_components=graph_type, init='pca', random_state=501)
    #        X_tsne = tsne.fit_transform(X)
            
        #    print("Org data dimension is {}. Embedded data dimension is {}".format(X.shape[-1], X_tsne.shape[-1])) color=plt.cm.Set3(y_norm[i])
    
    
            labels=np.unique(y)
            Representative_submatrix= np.empty(shape=[0, 120])
            for j in range(len(labels)):
                num=0;
                submatrix=np.zeros([1,120])
                for k in range(len(y)):
                    if labels[j]==y[k]:
                        submatrix=submatrix+data[k]
                        num=num+1
                Representative_submatrix=np.vstack((Representative_submatrix,submatrix/num))
            
        path='./Representative_submatrix/'+str(i+1)+'.npy'
        np.save(path, Representative_submatrix)
    