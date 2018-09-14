clear all
close all
clc

%% Declaracao da Matriz A global
global A

%%Declaracao das constantes
%%constantes do Grupo 13
c1=2;
c2=2;
c3=1;
c4=1;

m2=1;
m4=1;
k1=3600;
k3=3600;

%%Matrizes do sistema

M = [c4*m4 3*c4*m4/2;
     c2*m2 -c4*m4/2];
 
K = [0        c3*k3;
    c1*k1    -c3*k3];

A = [zeros(2) eye(2);
     -M\K    zeros(2)];
 
%Vetor das condicoes iniciais
y0 =[0.01 ;
    0;
    0;
    0];
%Intervalo de tempo da funcao ODE45 com passo de 0,001
tspan = 0:0.001:2;

sol = ode45(@f,tspan,y0,odeset('MaxStep',0.001));

t = sol.x;
x1 = sol.y(1,:);
x2 = sol.y(2,:);
x1dot = sol.y(3,:);
x2dot = sol.y(4,:);
%Saida Grafica
figure(1)

subplot(1,2,1)
plot(t,x1)
legend('x_1')

subplot(1,2,2)
plot(t,x1dot)
legend('x_1dot')

figure(2)

subplot(1,2,1)
plot(t,x2)
legend('x_2')

subplot(1,2,2)
plot(t,x2dot)
legend('x_2dot')

figure (3)

plotyy(t,x1,t,x2)
legend('x_1','x_2')






