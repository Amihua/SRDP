function [Out] = Efficiency(G,k,name)
%计算图G的抽样计算效率和误差
% k是图G的KF指数，可以是0也可以提前算好
%----------初始值的定义------------
Time=zeros(1,10);
scale=[1,0.8,0.7,0.6,0.5,0.4,0.3,0.2,0.1,0.05];
index=[1,5,7,9,11,13,15,17,19,21];
T=zeros(1,10); %(t1-t2)/t1
R=zeros(1,10); %直接预测误差，没有除以t
c_error=zeros(1,10);
p_error=zeros(1,10);
%----------计算图G的K时间和度与count的拟合------------
if k==0
    time1=clock;
    Kf_0=Kf(G);
    d=degree(G);count=histc(d,unique(d));
    a1=log10(unique(d));b1=log10(count);
    t1=sum(polyfit(a1,b1,1));
    time2=clock;
    Time(1)=etime(time2,time1);
else
    Kf_0=k;
    d=degree(G);count=histc(d,unique(d));
    a1=log10(unique(d));b1=log10(count);
    t1=sum(polyfit(a1,b1,1));
    Time(1)=0;
end
%---------------选择抽样方式并开始抽样计算--------------
if strcmp(name,'RW');
    parfor i=2:10
        time1=clock;
        g=RW(G,scale(i));
        gg=RW(g,scale(i));
        Kf_g=Kf(g);Kf_gg=Kf(gg);
        value=Kf_gg/Kf_g;
        d=degree(g);count=histc(d,unique(d));
        a2=log10(unique(d));b2=log10(count);
        t2=sum(polyfit(a2,b2,1));
        t=(t1-t2)/t1;T(i)=t;%系数误差
        Kf_1=Kf_g/value;
        c_error(i)=(Kf_0-Kf_1)/Kf_0;R(i)=abs(c_error(i));
        c_error(i)=abs(c_error(i)/t);%真实误差与系数误差比例
        Kf_1=Kf_1/(1-t); p_error(i)=abs((Kf_0-Kf_1)/Kf_0); %系数修正后的误差
        time2=clock;
        Time(i)=etime(time2,time1);
    end
elseif strcmp(name,'FW');
    parfor i=2:10
        time1=clock;
        g=FW(G,scale(i),8);
        gg=FW(g,scale(i),8);
        Kf_g=Kf(g);Kf_gg=Kf(gg);
        while isnan(Kf_g)
            g=FW(G,scale(i),8);;
            Kf_g=Kf(g);
        end
        while isnan(Kf_gg)
            gg=FW(g,scale(i),8);
            Kf_gg=Kf(gg);
        end
        value=Kf_gg/Kf_g;
        d=degree(g);count=histc(d,unique(d));
        a2=log10(unique(d));b2=log10(count);
        t2=sum(polyfit(a2,b2,1));
        t=(t1-t2)/t1;T(i)=t;%系数误差
        Kf_1=Kf_g/value;
        c_error(i)=(Kf_0-Kf_1)/Kf_0;R(i)=abs(c_error(i));
        c_error(i)=abs(c_error(i)/t);%真实误差与系数误差比例
        Kf_1=Kf_1/(1-t); p_error(i)=abs((Kf_0-Kf_1)/Kf_0); %系数修正后的误差
        time2=clock;
        Time(i)=etime(time2,time1);
    end
elseif strcmp(name,'FRW');
    for i=2:10
        time1=clock;
        g=FRW(G,scale(i),8);
        gg=FRW(g,scale(i),8);
        Kf_g=Kf(g);Kf_gg=Kf(gg);
        while isnan(Kf_g)
            g=FRW(G,scale(i),8);;
            Kf_g=Kf(g);
        end
        while isnan(Kf_gg)
            gg=FRW(g,scale(i),8);
            Kf_gg=Kf(gg);
        end
        value=Kf_gg/Kf_g;
        d=degree(g);count=histc(d,unique(d));
        a2=log10(unique(d));b2=log10(count);
        t2=sum(polyfit(a2,b2,1));
        t=(t1-t2)/t1;T(i)=t;%系数误差
        Kf_1=Kf_g/value;
        c_error(i)=(Kf_0-Kf_1)/Kf_0;R(i)=abs(c_error(i));
        c_error(i)=abs(c_error(i)/t);%真实误差与系数误差比例
        Kf_1=Kf_1/(1-t); p_error(i)=abs((Kf_0-Kf_1)/Kf_0); %系数修正后的误差
        time2=clock;
        Time(i)=etime(time2,time1);
    end
    
elseif strcmp(name,'SSRW');
    for i=2:10
        time1=clock;
        g=RW(G,scale(i));
        gg=SSRW(g,scale(i));
        Kf_g=Kf(g);Kf_gg=Kf(gg);
        while isnan(Kf_g)
            g=RW(G,scale(i));;
            Kf_g=Kf(g);
        end
        while isnan(Kf_gg)
            gg=SSRW(g,scale(i));
            Kf_gg=Kf(gg);
        end
        value=Kf_gg/Kf_g;
        d=degree(g);count=histc(d,unique(d));
        a2=log10(unique(d));b2=log10(count);
        t2=sum(polyfit(a2,b2,1));
        t=(t1-t2)/t1;T(i)=t;%系数误差
        Kf_1=Kf_g/value;
        c_error(i)=(Kf_0-Kf_1)/Kf_0;R(i)=abs(c_error(i));
        c_error(i)=abs(c_error(i)/t);%真实误差与系数误差比例
        Kf_1=Kf_1/(1-t); p_error(i)=abs((Kf_0-Kf_1)/Kf_0); %系数修正后的误差
        time2=clock;
        Time(i)=etime(time2,time1);
    end    
    
elseif strcmp(name,'SRW');
        for i=2:10
        time1=clock;
        g=RW(G,scale(i));
        gg=SRW(g,scale(i),1);
        Kf_g=Kf(g);Kf_gg=Kf(gg);
        while isnan(Kf_g)
            g=RW(G,scale(i));;
            Kf_g=Kf(g);
        end
        while isnan(Kf_gg)
            gg=SRW(g,scale(i),1);
            Kf_gg=Kf(gg);
        end
        value=Kf_gg/Kf_g;
        d=degree(g);count=histc(d,unique(d));
        a2=log10(unique(d));b2=log10(count);
        t2=sum(polyfit(a2,b2,1));
        t=(t1-t2)/t1;T(i)=t;%系数误差
        Kf_1=Kf_g/value;
        c_error(i)=(Kf_0-Kf_1)/Kf_0;R(i)=abs(c_error(i));
        c_error(i)=abs(c_error(i)/t);%真实误差与系数误差比例
        Kf_1=Kf_1/(1-t); p_error(i)=abs((Kf_0-Kf_1)/Kf_0); %系数修正后的误差
        time2=clock;
        Time(i)=etime(time2,time1);
        end
end
%----------计算采样图-----------------

Out.Time=Time;
Out.c_error=c_error;%真实误差与系数误差比例（就是R/T）
Out.p_error=p_error;%除以系数后的误差（与Kf_0比较）
Out.T=T; %系数误差
Out.R=R; %没有除以t，直接预测的误差（与Kf_0比较）

