%% Matriz DH para cinemática direta de robos manipuladores 

clear all
clc

%% Define as variaveis simbolicas

syms alpha d a theta

%% numero de juntas

N=2;

%% Elabore a tabela DH

DHTABLE = [  0   sym('a1')    0      sym('q1');
             0   sym('a2')    0      sym('q2')];

         
%% Matriz de transformação geral

TDH = [ cos(theta) -sin(theta)*cos(alpha)  sin(theta)*sin(alpha) a*cos(theta);
        sin(theta)  cos(theta)*cos(alpha) -cos(theta)*sin(alpha) a*sin(theta);
          0             sin(alpha)             cos(alpha)            d;
          0               0                      0                   1];

%% Construção da matriz para cada angulo
% Criar primeiro uma matriz zero

A = cell(1,N);

% Substituir a matriz pelas variaveis

for i = 1:N
    alpha = DHTABLE(i,1);
    a = DHTABLE(i,2);
    d = DHTABLE(i,3);
    theta = DHTABLE(i,4);
    A{i} = subs(TDH);
end

%% Cinemática Direta

disp('Cinemática direta na forma simbolitca')

disp(['Número de juntas N=',num2str(N)])



T = eye(4); % Matriz identidade

for i=1:N 
    T = T*A{i};
    T = simplify(T);
end

% Matriz homogenea do efetuador em relação a base

T0N = T

% Posição

p = T(1:3,4)

% Eixo xN

n=T(1:3,1)

% Eixo yN

s=T(1:3,2)

% Eixo zN

a=T(1:3,3)

%% end


%%% Desenhando o manipulador

a1=2; %link 1
a2=1; %link 2

% % Posição
% %Elo 1
% T1=A{1}
% p1=subs(T1(1:3,4));
% %Elo 2
% pf = subs(T(1:3,4));


%% generating images in 2D
figure (1)
q1=0
for q2=0:0.1:1.6
    %Elo 1
   T1=A{1};
   p1=subs(T1(1:3,4));
   %Elo 2
   pf = subs(T(1:3,4));
hold off
plot([p1(1) pf(1)],[p1(2) pf(2)],'o',[0 p1(1)],[0 p1(2)],'k',[p1(1) pf(1)],[p1(2) pf(2)],'k')
title('Movimento de 2G.L.')
xlabel('x')
ylabel('y')
axis([-3 3 -3 3]);
grid
hold on
MM(i)=getframe(gcf);
q1=q1+0.1;
end
drawnow;
