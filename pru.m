function [r,n,tb] = Ecudif(x,y,n,in)
%x=x + coef atrasos entrada
%y=atrasos salida
% n=entrada
% in= ubicacion del 0 entrada

mL=0;
if (length(x)-1>in||length(y)>in)&&in>0
    
    mL=max([length(y) length(x)-1])-in+1;
    n=[zeros(1,mL) n];
    in=in+mL;
end
if in<0%  condiciones iniciales = 0
    if length(x)-1>abs(in)||length(y)>abs(in)
        
        mL=max([length(y) length(x)-1]);
        n=[zeros(1,mL) n]
        in=mL+1;
    else
        n=[zeros(1,abs(in)) n];
        in=abs(in)+1;
    end
elseif in==0
    error('Ubicacion debe ser un entero');
elseif in>length(n)
    n=[n zeros(1,in)];
    in=length(n);
end



tit={'k','n',[num2str(x(1)) '*x']};

for i=4:length(x)+2
    tit(i)={[num2str(x(i-2)) '*x(n-' num2str(i-3) ')']};
end

for i=length(x)+3:length(y)+length(x)+2
    tit(i)={[num2str(y(i-length(y)-length(x)+2)) '*y(n-' num2str(i-length(y)-length(x)+2) ')']};
end

tit(end)={'Tot'};
x=fliplr(x);
y=fliplr(y);
r=zeros(1,length(n));

tb=[-(length(n)-in-1):length(n)]'
tb=[tb zeros(length(tb),1+length(x)+length(y))]
% tb(i)=[x.*n(i-length(x)+1:i) y.*r(i-length(y):i-1)];
tb(:,2)=[zeros(length(tb(:,2))-length(n),1); n'];
for i=in:length(n)
    
    if ((i-length(x))>0)&&((i-length(y)-1)>0)        
        tb(i,3:end)=[x.*n(i-length(x)+1:i) y.*r(i-length(y):i-1)];
        r(i)=sum(tb(i,2:end));
        tb(i,end)=r(i);
    elseif (i-length(x)+1)>0
        tb(i,3:end)=[x.*n(i-length(x)+1:i) zeros(1,length(y))]
        r(i)=sum(tb(i,2:end));
        tb(i,end)=r(i);
    elseif (i-length(y)+1)>0
        tb(i,3:end)=[zeros(1,length(x)) y.*r(i-length(y):i-1)];
        r(i)=sum(tb(i,2:end));
        tb(i,end)=r(i);
    end
    
    
end

if mL
    r(1:mL)=[];
end
tb=[zeros(1,length(tit));tb];
tb=num2cell(tb);
for i=1:length(tit)
    tb{1,i}= string(tit(i));
end



end

