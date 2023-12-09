clear all
close all
clc
%
xn=[-1 1 -0.5 0.5 0 0]%entrada
in=1%ubicacion 0 en el vector
x=[1 -0.5 0.25]%coeficientes atrasos salida
y=[0]%coeficientes adelanto salida
[yn,xn,tb] =Ecudif(x,y,xn,in)%aplicacion entrada
x1n=[-1 1 -0.5 0.5]%
m=length(yn);
n=length(x1n);
%expansion de vectores
X=[yn,zeros(1,n)];
H=[x1n,zeros(1,m)];
for i=1:n+m-1
    cv(i)=0;
    for j=1:m 
        if(i-j+1>0)
            cv(i)=cv(i)+X(j)*H(i-j+1);%espejo
        else
        end
    end
end
%comprobacion
disp('paso a paso')
cv
disp('funcion')
cv=conv(yn,x1n)

%Mostrar
figure()
hold on 
n=0:length(x1n)-1;%entrada
stem(n,x1n,'*','Color','r','LineWidth',3)
n=0:length(yn)-1;%salida
stem(n,yn,'x','Color','b','LineWidth',2)
n=0:length(cv)-1;%convolucion
stem(n,cv,'o','Color','g','LineWidth',2)
hold off
legend('x1n','yn','cv')


