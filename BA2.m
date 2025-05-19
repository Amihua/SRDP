function [ B ] = BA2( A )
%计算图的S指数
%  
N=max(size(A));
S=2*Randic(A)/N;m=sum(sum(A))/2;p1=(2*m)/(N*(N-1));R1=0;
% for i=1:20
%     ER1=ERR(N,p1);
%     r=Randic(ER1);
%     R1=R1+r;
% end
% R1=R1/20;
R1=N/(2*(N-1)*p1);
a=S/R1;
B=a;
end

