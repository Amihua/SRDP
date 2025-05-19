function  [ ]= plotMG( A ,Edge,c)
%UNTITLED2 此处显示有关此函数的摘要
%   此处显示详细说明
if(nargin<3)
    c=1;
end
m=A.m;n=A.n;
X=linspace(0,100,n);
X=X';
X=repmat(X,1,m);
X=X(:);
Y=linspace((m-1)*100/(n-1),0,m);
Y=repmat(Y,n,1);
Y=Y(:);
scatter(X,Y,300,'k','filled');%绘画散点圆圈
hold on;
for i=1:m
    plot(X(n*(i-1)+1:i*n),Y(n*(i-1)+1:i*n),'k')
end
for i=1:n
    plot(X(i:n:(m-1)*n+i),Y(i:n:(m-1)*n+i),'k')
end
axis equal;axis off;
N=[1:m*n];
text(X-2.1,Y,num2str(N(:)),'Color','white');%给圆圈标注 序号

if c==1
    k=size(Edge.max,2);
    for i=1:k
        a=[X(Edge.max(1,i)),X(Edge.max(2,i))];b=[Y(Edge.max(1,i)),Y(Edge.max(2,i))];
        plot(a,b,'r','LineWidth',2)
    end
    k=size(Edge.min,2);
    for i=1:k
        a=[X(Edge.min(1,i)),X(Edge.min(2,i))];b=[Y(Edge.min(1,i)),Y(Edge.min(2,i))];
        plot(a,b,'b','LineWidth',2)
    end
elseif c==2
    k=size(Edge.x{Edge.max},2);
    for i=1:k
        a=[X(Edge.x{Edge.max}(1,i)),X(Edge.y{Edge.max}(1,i))];
        b=[Y(Edge.x{Edge.max}(1,i)),Y(Edge.y{Edge.max}(1,i))];
        plot(a,b,'r','LineWidth',2)
    end
    k=size(Edge.x{Edge.min},2);
    for i=1:k
        a=[X(Edge.x{Edge.min}(1,i)),X(Edge.y{Edge.min}(1,i))];
        b=[Y(Edge.x{Edge.min}(1,i)),Y(Edge.y{Edge.min}(1,i))];
        plot(a,b,'b','LineWidth',2)
    end
    
end





