function [ B ] = BA4( A,n )
%UNTITLED 此处显示有关此函数的摘要
%   这里ER随机图的randic 通过公式计算的
% 随机丢失结点的计算方法
% h = waitbar(0,'Please wait...');%计算进程用的
B=zeros(1,n);S1=Randic(A);m1=sum(sum(A))/2;N=size(A,2);
p1=(2*m1)/(N*(N-1));R1=0;b=[];
rank=randperm(N);
rank=rank(1:n);
R1=N/(2*(N-1)*p1); a=S1/R1;
for i=1:n
    k=rank(1,1:i);Aa=A;
    Aa(k,:)=[];Aa(:,k)=[];R=0;
    S=Randic(Aa);m=sum(sum(Aa))/2;p=(2*m)/((N-i)*(N-1-i));
    R=(N-i)/(2*(N-i)*p);b=S/R;
    %B(1,i)=(1-S/S1);
    B(1,i)=(1-S/S1)*(R/R1);
    %B(1,i)=1-((N*N-1)*b)/((N-i)*(N-1-i)*a);
%     per = i/n;
%     waitbar(per, h ,sprintf('%2.0f%%',per*100)) 
end

end