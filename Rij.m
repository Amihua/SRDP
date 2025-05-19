function [ Rank ] = Rij( A )
%UNTITLED3 此处显示有关此函数的摘要
%   此处显示详细说明
m=A.m;n=A.n;R=[];L=Laplacian(A.a);
for i=1:m
    t=n*(i-1)+2;tt=n*i;
    for ii=t:tt;
        B=L;
        B(ii-1,:)=[];B(:,ii-1)=[]; c=det(B);B(ii-1,:)=[];B(:,ii-1)=[];d=det(B);
        r=d/c;
        R=[R;r,ii-1,ii];
    end 
end
for i=1:m-1;
    t=n*(i-1)+1;tt=n*i;
    for ii=t:tt;
        B=L;
        B(ii,:)=[];B(:,ii)=[];c=det(B);B(ii+n-1,:)=[];B(:,ii+n-1)=[];d=det(B);
        r=d/c;
        R=[R;r,ii,ii+n];
    end
end
%排名Rij
R=sortrows(-1*R,1);R=-1*R;Index=1;
Rank.r{1}=[R(1,1)];Rank.x{1}=[R(1,2)];Rank.y{1}=[R(1,3)];
for i=2:((n-1)*m+(m-1)*n)
    if (R(i-1,1)-R(i,1))>0.00001
        Index=Index+1;
        Rank.r{Index}=[R(i,1)];Rank.x{Index}=[R(i,2)];Rank.y{Index}=[R(i,3)];
    else
        Rank.x{Index}=[Rank.x{Index},R(i,2)];
        Rank.y{Index}=[Rank.y{Index},R(i,3)];
    end
end
Rank.max=floor(n/2);
Rank.min=n-1;


end

