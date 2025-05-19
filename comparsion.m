S=[];K=[];
for i=1:100;
    A=BA(2500,5,4);
    s=BA3(A,20);
    k=Kfrange(A,20);
    S=[S;s];
    K=[K;k];
end