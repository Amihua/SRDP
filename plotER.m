function c= plotER( A )
N=max(size(A));
position=zeros(N,2);   %��λ����Ϣposition,һ����N�����ݣ�ÿ��������2����Ϣ
for m=1:N           %��ÿ���㰲��λ�ã�Χ��һ��Բ
    position(m,1)=cos(m/N*2*pi);
    position(m,2)=sin(m/N*2*pi);
end
figure('name','ER���ͼ');
hold on;
plot(position(:,1),position(:,2),'d')
for m = 1:N
    for n = m+1:N
        if(A(m,n)==1)  %����б߾ͻ�����
            plot(position([m,n],1),position([m,n],2));
        end
    end
end
hold off;

end

