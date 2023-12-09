function [yn,xn,tb] = Ecudif(x,y,xn,in)
%x=x + coef atrasos entrada
%y=atrasos salida
% n=entrada
% n<0 cuantos 0 hay antes del primer valor
% in= ubicacion del 0 entrada

mL=0;
if (length(x)-1>=in||length(y)>=in)&&in>0
    
    mL=max([length(y) length(x)-1])-in+1;
    xn=[zeros(1,mL) xn];
    in=in+mL;
end
if in<0%  condiciones iniciales = 0
    if length(x)-1>=abs(in)||length(y)>=abs(in)
        
        mL=max([length(y) length(x)-1]);
        xn=[zeros(1,mL) xn]
        in=mL+1;
    else
        xn=[zeros(1,abs(in)) xn];
        in=abs(in)+1;
    end
elseif in==0
    error('Ubicacion debe ser un entero');
elseif in>length(xn)
    xn=[xn zeros(1,in)];
    in=length(xn);
end



tit={'n','x(n)',[num2str(x(1)) '*x']};

for i=4:length(x)+2
    tit(i)={[num2str(x(i-2)) '*x(n-' num2str(i-3) ')']};
end

for i=length(x)+3:length(y)+length(x)+2
    tit(i)={[num2str(y(i-length(x)-2)) '*y(n-' num2str(i-length(x)-2) ')']};
end

tit(end)={'y(n)'};
x=fliplr(x);
y=fliplr(y);
yn=zeros(1,length(xn));

tb=[-in+1:length(xn)-1]';
tb=[tb zeros(length(tb),1+length(x)+length(y))];
tb(:,2)=[xn';zeros(length(tb(:,2))-length(xn),1)];
for i=in:length(xn)
    
    if ((i-length(x)+1)>0)&&((i-length(y)+1)>0)
        tb(i,3:end)=[fliplr(x.*xn(i-length(x)+1:i)) fliplr(y.*yn(i-length(y):i-1))];
        yn(i)=sum(tb(i,3:end));
        tb(i,end)=yn(i);
    elseif (i-length(x)+1)>0
        tb(i,3:end)=[fliplr(x.*xn(i-length(x)+1:i)) zeros(1,length(y))];
        yn(i)=sum(tb(i,3:end));
        tb(i,end)=yn(i);
    elseif (i-length(y))>0
        tb(i,3:end)=[zeros(1,length(x)) fliplr(y.*yn(i-length(y):i-1))];
        yn(i)=sum(tb(i,3:end));
        tb(i,end)=yn(i);
    end
    
    
end

if mL
    yn(1:mL)=[];
end
tb=[zeros(1,length(tit));tb];
tb=num2cell(tb);
for i=1:length(tit)
    tb{1,i}= string(tit(i));
end
for i = 1:length(xn)
    C{1,i} = xn(i);
    if i==in
        C{2,i} ='î';
        
    else
%         C{2,i} ='';
    end
end
figure()
n=-in+1:length(xn)-in;
stem(n,xn,'*','Color','r','LineWidth',1)
n=0:length(yn)-1;
hold on
stem(n,yn,'o','Color','b','LineWidth',2)
hold off
legend('xn','yn')
xn=C;

end

