import Hierarchical_clustering
import Second_Hierarchical_clustering
import Get_feature


for data_number in range(4,5):
    for t1 in range(9,10):
        t1=t1*0.5
        Hierarchical_clustering.frist_Hierarchical(t1,data_number)
        for t2 in range(6,7):
            t2=t2*0.5
            Second_Hierarchical_clustering.Second_Hierarchical(t2)
            Get_feature.Get_feature(t1,t2,data_number)


