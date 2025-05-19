function [BB] = NaN_average(B)
%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明
BB=[];
for i=1:200
    count=0;a=0;
    for ii=1:100
        if isnan(B(ii,i))==0
            a=a+B(ii,i);
            count=count+1;
        end
    end
    if count==0
        a=NaN;
    else
        a=a/count;
    end
    BB=[BB,a];
end
end

