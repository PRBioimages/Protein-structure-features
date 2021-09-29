import torch as th
import matplotlib.pyplot as plt
import dgl
import numpy as np
import networkx as nx
import scipy.io as sio
import scipy.sparse as spp
import torch
import h5py
import tensorflow as tf
from torch.utils.data import Dataset, DataLoader
from keras.models import Model
from keras.layers import Input, Dense, Flatten, Dropout, TimeDistributed, Concatenate, Add
from keras.optimizers import Adam
torch.set_default_tensor_type(torch.DoubleTensor)

class QM7bDataset(Dataset):

    def __init__(self,train_or_test,fold):
        super().__init__()
        self.train_or_test = train_or_test
        self.fold = fold

        self.features = []
        self.adj = []
        self.labels = []

        if train_or_test==1:
            i=fold

            if i==1:
                for j in range(1052):
                    if (j+1>=28 and j+1<=275) or (j+1>=287 and j+1<=386) or(j+1>=425 and j+1<=771) or(j+1>=800 and j+1<=1052):
                        name='/home/gwang/DGL_GCN/1052data/Cluster_feature_10_42D/'+str(j+1)+'.mat'
                        try:
                            data = sio.loadmat(name)
                            nodes_feature=data['Cluster_features']  
                        except:
                            data=h5py.File(name,'r')
                            nodes_feature=np.transpose(data['Cluster_features'])
#                        if len(nodes_feature)<3 or len(nodes_feature)>1000:
#                            continue
                        self.features.append(nodes_feature)
    
                        name='/home/gwang/DGL_GCN/1052data/adj/'+str(j+1)+'.mat'
                        try:
                            data = sio.loadmat(name)
                            graph_matrix=data['adj_matrix']
                        except:
                            data=h5py.File(name,'r')
                            graph_matrix=np.transpose(data['adj_matrix'])
                        self.adj.append(graph_matrix)
                        
                        if j+1>=1 and j+1<=275:
                            self.labels.append(0)
                        if j+1>=276 and j+1<=386:
                            self.labels.append(1)
                        if j+1>=387 and j+1<=771:
                            self.labels.append(2)
                        if j+1>=772 and j+1<=1052:
                            self.labels.append(3)
                        
        
            if i>=2 and i<=9:
                for j in range(1052):
                    if (j+1>=1 and j+1<=27+(i-1)*27)or(j+1>=276 and j+1<=286+(i-1)*11)or(j+1>=387 and j+1<=424+(i-1)*38)or(j+1>=772 and j+1<=799+(i-1)*28):
                        name='/home/gwang/DGL_GCN/1052data/Cluster_feature_10_42D/'+str(j+1)+'.mat'
                        try:
                            data = sio.loadmat(name)
                            nodes_feature=data['Cluster_features']  
                        except:
                            data=h5py.File(name,'r')
                            nodes_feature=np.transpose(data['Cluster_features'])
#                        if len(nodes_feature)<3 or len(nodes_feature)>1000:
#                            continue
                        self.features.append(nodes_feature)
    
                        name='/home/gwang/DGL_GCN/1052data/adj/'+str(j+1)+'.mat'
                        try:
                            data = sio.loadmat(name)
                            graph_matrix=data['adj_matrix']
                        except:
                            data=h5py.File(name,'r')
                            graph_matrix=np.transpose(data['adj_matrix'])
                        self.adj.append(graph_matrix)
                        
                        if j+1>=1 and j+1<=275:
                            self.labels.append(0)
                        if j+1>=276 and j+1<=386:
                            self.labels.append(1)
                        if j+1>=387 and j+1<=771:
                            self.labels.append(2)
                        if j+1>=772 and j+1<=1052:
                            self.labels.append(3)
                        
                        
                    if (j+1>=55+(i-1)*27 and j+1<=275)or(j+1>=298+(i-1)*11 and j+1<=386)or(j+1>=463+(i-1)*38 and j+1<=771)or(j+1>=828+(i-1)*28 and j+1<=1052):
                        name='/home/gwang/DGL_GCN/1052data/Cluster_feature_10_42D/'+str(j+1)+'.mat'
                        try:
                            data = sio.loadmat(name)
                            nodes_feature=data['Cluster_features']  
                        except:
                            data=h5py.File(name,'r')
                            nodes_feature=np.transpose(data['Cluster_features'])
#                        if len(nodes_feature)<3 or len(nodes_feature)>1000:
#                            continue
                        self.features.append(nodes_feature)
    
                        name='/home/gwang/DGL_GCN/1052data/adj/'+str(j+1)+'.mat'
                        try:
                            data = sio.loadmat(name)
                            graph_matrix=data['adj_matrix']
                        except:
                            data=h5py.File(name,'r')
                            graph_matrix=np.transpose(data['adj_matrix'])
                        self.adj.append(graph_matrix)
                        
                        if j+1>=1 and j+1<=275:
                            self.labels.append(0)
                        if j+1>=276 and j+1<=386:
                            self.labels.append(1)
                        if j+1>=387 and j+1<=771:
                            self.labels.append(2)
                        if j+1>=772 and j+1<=1052:
                            self.labels.append(3)
                            
            if i==10:
                for j in range(1052):               
                    if (j+1>=1 and j+1<=243)or(j+1>=276 and j+1<=374)or(j+1>=387 and j+1<=728)or(j+1>=772 and j+1<=1023):
                        name='/home/gwang/DGL_GCN/1052data/Cluster_feature_10_42D/'+str(j+1)+'.mat'
                        try:
                            data = sio.loadmat(name)
                            nodes_feature=data['Cluster_features']  
                        except:
                            data=h5py.File(name,'r')
                            nodes_feature=np.transpose(data['Cluster_features'])
#                        if len(nodes_feature)<3 or len(nodes_feature)>1000:
#                            continue
                        self.features.append(nodes_feature)
    
                        name='/home/gwang/DGL_GCN/1052data/adj/'+str(j+1)+'.mat'
                        try:
                            data = sio.loadmat(name)
                            graph_matrix=data['adj_matrix']
                        except:
                            data=h5py.File(name,'r')
                            graph_matrix=np.transpose(data['adj_matrix'])
                        self.adj.append(graph_matrix)
                        
                        if j+1>=1 and j+1<=275:
                            self.labels.append(0)
                        if j+1>=276 and j+1<=386:
                            self.labels.append(1)
                        if j+1>=387 and j+1<=771:
                            self.labels.append(2)
                        if j+1>=772 and j+1<=1052:
                            self.labels.append(3)

        if train_or_test==2:
            i=fold
            if i==1:
                for j in range(1052):
                    if (j+1>=1 and j+1<=27)or(j+1>=276 and j+1<=286)or(j+1>=387 and j+1<=424)or(j+1>=772 and j+1<=799):
                        name='/home/gwang/DGL_GCN/1052data/Cluster_feature_10_42D/'+str(j+1)+'.mat'
                        try:
                            data = sio.loadmat(name)
                            nodes_feature=data['Cluster_features']  
                        except:
                            data=h5py.File(name,'r')
                            nodes_feature=np.transpose(data['Cluster_features'])
#                        if len(nodes_feature)<3 or len(nodes_feature)>1000:
#                            continue
                        self.features.append(nodes_feature)
    
                        name='/home/gwang/DGL_GCN/1052data/adj/'+str(j+1)+'.mat'
                        try:
                            data = sio.loadmat(name)
                            graph_matrix=data['adj_matrix']
                        except:
                            data=h5py.File(name,'r')
                            graph_matrix=np.transpose(data['adj_matrix'])
                        self.adj.append(graph_matrix)
                        
                        if j+1>=1 and j+1<=275:
                            self.labels.append(0)
                        if j+1>=276 and j+1<=386:
                            self.labels.append(1)
                        if j+1>=387 and j+1<=771:
                            self.labels.append(2)
                        if j+1>=772 and j+1<=1052:
                            self.labels.append(3)

            if i>=2 and i<=9:
                for j in range(1052):
                        name='/home/gwang/DGL_GCN/1052data/Cluster_feature_10_42D/'+str(j+1)+'.mat'
                        try:
                            data = sio.loadmat(name)
                            nodes_feature=data['Cluster_features']  
                        except:
                            data=h5py.File(name,'r')
                            nodes_feature=np.transpose(data['Cluster_features'])
#                        if len(nodes_feature)<3 or len(nodes_feature)>1000:
#                            continue
                        self.features.append(nodes_feature)
    
                        name='/home/gwang/DGL_GCN/1052data/adj/'+str(j+1)+'.mat'
                        try:
                            data = sio.loadmat(name)
                            graph_matrix=data['adj_matrix']
                        except:
                            data=h5py.File(name,'r')
                            graph_matrix=np.transpose(data['adj_matrix'])
                        self.adj.append(graph_matrix)
                        
                        if j+1>=1 and j+1<=275:
                            self.labels.append(0)
                        if j+1>=276 and j+1<=386:
                            self.labels.append(1)
                        if j+1>=387 and j+1<=771:
                            self.labels.append(2)
                        if j+1>=772 and j+1<=1052:
                            self.labels.append(3)
                            
            if i==10:
                for j in range(1052):
                        name='/home/gwang/DGL_GCN/1052data/Cluster_feature_10_42D/'+str(j+1)+'.mat'
                        try:
                            data = sio.loadmat(name)
                            nodes_feature=data['Cluster_features']  
                        except:
                            data=h5py.File(name,'r')
                            nodes_feature=np.transpose(data['Cluster_features'])
#                        if len(nodes_feature)<3 or len(nodes_feature)>1000:
#                            continue
                        self.features.append(nodes_feature)
    
                        name='/home/gwang/DGL_GCN/1052data/adj/'+str(j+1)+'.mat'
                        try:
                            data = sio.loadmat(name)
                            graph_matrix=data['adj_matrix']
                        except:
                            data=h5py.File(name,'r')
                            graph_matrix=np.transpose(data['adj_matrix'])
                        self.adj.append(graph_matrix)
                        
                        if j+1>=1 and j+1<=275:
                            self.labels.append(0)
                        if j+1>=276 and j+1<=386:
                            self.labels.append(1)
                        if j+1>=387 and j+1<=771:
                            self.labels.append(2)
                        if j+1>=772 and j+1<=1052:
                            self.labels.append(3)

    def __getitem__(self, index):
        return self.features[index], self.adj[index], self.labels[index]
 
    def __len__(self):
        return len(self.features) 
    
    
    
    
import torch.nn as nn
import torch.nn.functional as F

"""
class GATLayerAdj(nn.Module):
    def __init__(self,d_i,d_o,act=F.relu,eps=1e-6):
        super(GATLayerAdj,self).__init__()
        self.f = nn.Linear(2*d_i,d_o)
        self.w = nn.Linear(2*d_i,1)
        self.b = nn.Linear(2*d_o,d_o)
        self.act = act
        self._init_weights()
    
    def _init_weights(self):
        nn.init.xavier_uniform_(self.f.weight)
        nn.init.xavier_uniform_(self.w.weight)
        nn.init.xavier_uniform_(self.b.weight)
    def forward(self,x,adj):
        N = x.size()[0]
        hsrc = x.unsqueeze(0).expand(N,-1,-1) # 1,N,i
        htgt = x.unsqueeze(1).expand(-1,N,-1) # N,1,i
        
        h = torch.cat([hsrc,htgt],dim=2) # N,N,2i
        
        a = self.w(h) # N,N,1
        a_sqz = a.squeeze(2) # N,N
        a_zro = -1e16*torch.ones_like(a_sqz) # N,N
        a_msk = torch.where(adj>0,a_sqz,a_zro) # N,N
        a_att = F.softmax(a_msk,dim=1) # N,N

        y = self.act(self.f(h)) # N,N,o
        y_att = a_att.unsqueeze(-1)*y # N,N,o
        o = y_att.sum(dim=1).squeeze()
        o1,unused=o.max(dim=0)
        o2 = o.sum(dim=0).squeeze()/len(o)
        o3 = torch.cat([o1,o2])
        o=self.b(o3)
        return o
"""

class GATLayerAdj(nn.Module):
    def __init__(self,d_i,d_o,act=F.relu,eps=1e-6):
        super(GATLayerAdj,self).__init__()
        self.f = nn.Linear(2*d_i,d_o)
        self.w = nn.Linear(2*d_i,1)
        self.b = nn.Linear(2*d_o,d_o)
        self.act = act
        self._init_weights()
    
    def _init_weights(self):
        nn.init.xavier_uniform_(self.f.weight)
        nn.init.xavier_uniform_(self.w.weight)
        nn.init.xavier_uniform_(self.b.weight)
    def forward(self,x,adj):
        N = x.size()[0]
        hsrc = x.unsqueeze(0).expand(N,-1,-1) # 1,N,i
        htgt = x.unsqueeze(1).expand(-1,N,-1) # N,1,i
        
        h = torch.cat([hsrc,htgt],dim=2) # N,N,2i
        
        a = self.w(h) # N,N,1
        a_sqz = a.squeeze(2) # N,N
        a_zro = -1e16*torch.ones_like(a_sqz) # N,N
        
        a_msk = torch.where(adj>0,a_sqz,a_zro) # N,N
        a_att = F.softmax(a_msk,dim=1) # N,N
        
        y = self.act(self.f(h)) # N,N,o
        y_att = a_att.unsqueeze(-1)*y # N,N,o
        
        o = y_att.sum(dim=1).squeeze()
        return o,a_att
    

class model_3DGCN(nn.Module):
    def __init__(self,n,m):
        super(model_3DGCN,self).__init__()
        self.num_layers = n
        self.outputs = m
        self.b2 = nn.Linear(2*42,m)
        self.GATLayerAdj = GATLayerAdj(42,42)

    def _init_weights(self):
        nn.init.xavier_uniform_(self.b2.weight)
    def forward(self,x,adj):
        feature_update=x
        for _ in range(self.num_layers):
            feature_update,a_att=self.GATLayerAdj(feature_update, adj)
            
            
            
            
            
        
        feature_max,unused=feature_update.max(dim=0)
        feature_ave = feature_update.sum(dim=0).squeeze()/len(feature_update)
        feature = torch.cat([feature_max,feature_ave])
        output=self.b2(feature)
        return output,a_att,feature



import torch.optim as optim


# Create training and test sets.

# Use DGL's GraphDataLoader. It by default handles the 
# graph batching operation for every mini-batch.


fold=1;
trainset = QM7bDataset(1,fold)
testset = QM7bDataset(2,fold)

for net_id in range(99,100):
    print(net_id)
    pkl_path='./model/'+str(fold)+'/net'+str(net_id)+'.pkl'
    # Create model
    model = model_3DGCN(3,5)
    loss_func = nn.CrossEntropyLoss()
    optimizer = optim.Adam(model.parameters(), lr=0.0001)
    
    checkpoint = torch.load(pkl_path)
    model.load_state_dict(checkpoint['net'])              # 加载模型可学习参数
    optimizer.load_state_dict(checkpoint['optimizer'])  # 加载优化器
    start_epoch = checkpoint['epoch']                   # 加载训练轮数
    """
    data_loader = DataLoader(trainset, batch_size=1, shuffle=True)
    
    for iter, (features, adj, label) in enumerate(data_loader):
            print('%d'%(iter) , end='\r')
            features=np.squeeze(features)
            adj=np.squeeze(adj)
            prediction = model(features, adj)
            prediction=prediction.view(1,len(prediction))
    """
    
    test_data_loader = DataLoader(testset, batch_size=1, shuffle=False, num_workers=0)
    for iter, (test_bg, test_adj, test_label) in enumerate(test_data_loader):
        test_bg=np.squeeze(test_bg)
        test_adj=np.squeeze(test_adj)
    
        prediction,a_att,feature=model(test_bg,test_adj)
#        a_att = a_att.detach().numpy()
#        att_path='./att/'+str(fold)+'/'+str(iter+1)+'.mat'
#        sio.savemat(att_path, {'att': a_att})

        feature = feature.detach().numpy()
        feature_path='./feature/'+str(fold)+'/'+str(iter+1)+'.mat'
        sio.savemat(feature_path, {'feature': feature})        
        
        mid_Y = prediction.view(1,len(prediction))
        
        if iter==0:
            probs_Y=mid_Y
            test_Y=test_label
        else:
            probs_Y = torch.cat([probs_Y,mid_Y],dim=0)
            test_Y = torch.cat([test_Y,test_label],dim=0)
        if iter==len(testset)-2:# 测试集有一个数据无法训练，但是找不到，只能先跳过
            break
    
    #sampled_Y = torch.multinomial(probs_Y, 1)
    argmax_Y = torch.max(probs_Y, 1)[1].view(-1, 1)
    
    # F1-Score
    argmax_Y=probs_Y.argmax(axis=1)
    test_Y=test_Y.int()
    test_Y=test_Y.numpy()

    test_Y=test_Y.reshape(len(test_Y),)
    matrix_c=np.zeros((5,5))
    for i in range(len(test_Y)):
        matrix_c[test_Y[i]][argmax_Y[i]]=matrix_c[test_Y[i]][argmax_Y[i]]+1
#    print(matrix_c)
    a=matrix_c
    F1_score=np.zeros((1,5))
    for i in range(5):
        if a[i,i]==0:
            F1_score[0,i]=0
            continue
        p=a[i,i]/(sum(a[:,i]))
        r=a[i,i]/(sum(a[i]))
        F1_score[0,i]=2*(p*r)/(p+r)
    F1_ave=sum(F1_score[0])/5
    print(F1_ave)
#    argmax_Y=argmax_Y.numpy()
#    sio.savemat('./result/pre_test.mat', {'pre_test': argmax_Y})
#    sio.savemat('./result/ture_test.mat', {'ture_test': test_Y})
