N = 100;
S1=[];K1=[];S2=[];K2=[];%1系列保存故意删除，2系列保存随机删除
parfor_progress(N); % Initialize
parfor i=1:N
A=SW(2500,50,0.15); % Replace with real code
s1=BA3(A,20);s2=BA4(A,20);
k1=Kfrange(A,20);k2=Kfrange2(A,20);
S1=[S1;s1];S2=[S2;s2];
K1=[K1;k1];K2=[K2;k2];
parfor_progress; % Count
end
parfor_progress(0); % Clean up