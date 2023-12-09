clear all
close all
clc
%
xn=[0 1 2 3 4 5]%entrada
in=1%ubicacion 0 en el vector
x=[1 0.8 0.4 0.2]%coeficientes atrasos salida
y=[0.54 0.34]%coeficientes adelanto salida
[yn,xn,tb] =Ecudif(x,y,xn,in)%aplicacion entrada