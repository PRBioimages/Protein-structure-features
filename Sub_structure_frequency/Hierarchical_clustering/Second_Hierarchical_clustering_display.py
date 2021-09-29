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


graph_type=2
"""
All_Representative_submatrix=np.empty(shape=[0, 120])

for i in range(1904):
    path='./Representative_submatrix/'+str(i+1)+'.npy'
    Representative_submatrix=np.load(path)
    All_Representative_submatrix=np.vstack((All_Representative_submatrix,Representative_submatrix))
np.save('All_Representative_submatrix.npy',All_Representative_submatrix)
"""

All_Representative_submatrix=np.load('All_Representative_submatrix.npy')

row_rand_data = np.arange(All_Representative_submatrix.shape[0])
np.random.shuffle(row_rand_data)
print(row_rand_data)
row_rand = All_Representative_submatrix
#row_rand = All_Representative_submatrix[row_rand_data[0:200]]
selected_data=[]
for i in range(len(row_rand)):
    print(i)
    selected_data.append(row_rand[i]);
    
t0 = time.time()  
Z = sch.linkage(selected_data, method='ward')
f = sch.fcluster(Z, t=3.5, criterion='distance')  # t
Hierarchical_time = time.time() - t0
print ("time:%.4fs" % Hierarchical_time)
print(f)  #打印类标签
np.save('f.npy',f)
# t-SNE
X=selected_data
y=f

tsne = manifold.TSNE(n_components=graph_type, init='pca', random_state=501)
X_tsne = tsne.fit_transform(X)


  
'''Visualization'''
"""
A=[]
for j in range(len(X)):
    A.append(j+1)

fig = plt.figure(figsize=(5,3))
dn = sch.dendrogram(Z,labels=A)
plt.show()    
"""

x_min, x_max = X_tsne.min(0), X_tsne.max(0)
X_norm = (X_tsne - x_min) / (x_max - x_min)  # Normalized
np.save('X_norm.npy',X_norm)
y_min, y_max = y.min(0), y.max(0)
y_norm = ((y - y_min) / (y_max - y_min))*11  # Normalized
y_color=[];
for i in range(np.max(y)):
    y_color.append([np.random.uniform(0, 1),np.random.uniform(0, 1),np.random.uniform(0, 1)])

if graph_type==2:
    

    plt.figure(figsize=(8, 8))
    for i in range(X_norm.shape[0]):
        label=y[i]-1
#        plt.text(X_norm[i, 0], X_norm[i, 1], str(y[i]), color=[y_color[label][0],y_color[label][1],y_color[label][2]], 
#                 fontdict={'weight': 'bold', 'size': 5})
        plt.plot(X_norm[i, 0], X_norm[i, 1], 'o',markersize=3, color=[y_color[label][0],y_color[label][1],y_color[label][2]])
    plt.xticks([])
    plt.yticks([])
    plt.show()    
    
if graph_type==3:
    
    fig=plt.figure()
    ax = Axes3D(fig)
    for i in range(X_norm.shape[0]):
        label=y[i]-1
        ax.scatter(X_norm[i, 0], X_norm[i, 1],X_norm[i, 2],c=[y_color[label][0],y_color[label][1],y_color[label][2]],s=1)
    plt.xticks([])
    plt.yticks([])
    plt.show()      