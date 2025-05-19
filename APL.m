function [D1,D2]= APL(a)
%计算图的平均路径长度
%a(输入量)表示图的邻接矩阵
%a(输出量)表示所求最短路径的距离矩阵
    N=max(size(a.Nodes));
    D=zeros(N-1,N);
    for i=1:N-1;
        for j=i+1:N
            [p,d]=shortestpath(a,i,j);
            D(i,j)=d;
        end
    end
    D1=(2*sum(sum(D)))/(N*(N-1));
    D2=max(D);
            
% %建立邻接矩阵，若不还是对称矩阵，则变为对称矩阵
% n=length(a);
% %The main program
% a(a==0)=inf;
% %步骤2.1
% for k=1:(n-1)
%     b=[1:(k-1),(k+1):n];
%     kk=length(b);
%     a_id=k;
%     b1=(k+1):n;
%     kk1=length(b1);
%     %步骤2.2.1
%     while kk>0
%         for j=1:kk1
%             te=a(k,a_id)+a(a_id,b1(j));
%             if te<a(k,b1(j))
%                 a(k,b1(j))=te;
%             end
%         end      
%         miid=1;        
%         for j=2:kk
%             if a(k,b(j))<a(k,b(miid))
%                 miid=j;
%             end
%         end
%         
%         a_id=b(miid);
%         b=[b(1:(miid-1)),b((miid+1):kk)];
%         kk=length(b);
%         if a_id>k
%             miid1=find(b1==a_id);
%             b1=[b1(1:(miid1-1)),b1((miid1+1):kk1)];
%             kk1=length(b1);
%         end
%     end
%     for j=(k+1):n
%         a(j,k)=a(k,j);
%     end
%     APL=0;D=[];G=[0,0];
%     for i=1:n-1
%         APL=APL+sum(a(i+1:n));
%         D=[D,max(a(i+1:n))];
%     end
%     G1=2*APL/(n*(n-1));
%     G2=max(D);
%     
%     %求图的直径

end