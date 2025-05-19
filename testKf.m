function[ A ]= testKf(n,m)
%5*n即是测试里面最大顶点数目的图，每组生成m次数据计算。
N=5;A=zeros(n,m);
for i=1:n;
    N=5*i;
    for ii=1:m;
        A(i,ii)=Kf(ER(N,0.5));
    end
end