function [ A ] = MeshGraph(m,n)
%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明
A.m=m;A.n=n;
A.a=zeros(m*n,m*n);
for i=1:m;
    t=n*(i-1)+2;tt=n*i;
    for ii=t:tt;
        A.a(ii,ii-1)=1;A.a(ii-1,ii)=1;
    end
end

for i=1:m-1
    t=n*(i-1)+1;tt=n*i;
    for ii=t:tt
        A.a(ii,ii+n)=1;A.a(ii+n,ii)=1;
    end
end

