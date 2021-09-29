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


def Second_Hierarchical(t_value):

    All_Representative_submatrix=np.empty(shape=[0, 120])
    
    for i in range(1052):
        path='./Representative_submatrix/'+str(i+1)+'.npy'
        Representative_submatrix=np.load(path)
        All_Representative_submatrix=np.vstack((All_Representative_submatrix,Representative_submatrix))
        
    
        
    t0 = time.time()  
    Z = sch.linkage(All_Representative_submatrix, method='ward')
    f = sch.fcluster(Z, t=t_value, criterion='distance')  # t
    Hierarchical_time = time.time() - t0
    print ("time:%.4fs" % Hierarchical_time)
    print(f)  
    
    # t-SNE
    X=All_Representative_submatrix
    y=f
    
    #    print("Org data dimension is {}. Embedded data dimension is {}".format(X.shape[-1], X_tsne.shape[-1])) color=plt.cm.Set3(y_norm[i])
    labels=np.unique(y)
    Representative_submatrix= np.empty(shape=[0, 120])
    for j in range(len(labels)):
        num=0;
        submatrix=np.zeros([1,120])
        for k in range(len(y)):
            if labels[j]==y[k]:
                submatrix=submatrix+All_Representative_submatrix[k]
                num=num+1
        Representative_submatrix=np.vstack((Representative_submatrix,submatrix/num))
    
    path='./Representative_submatrix/Second_Representative_submatrix.npy'
    np.save(path, Representative_submatrix)