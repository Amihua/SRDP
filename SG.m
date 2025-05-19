function [G] = SG(n)
%创建星图
G=zeros(n,n);
G(1,:)=1;
G(:,1)=1;
G(1,1)=0;
end

