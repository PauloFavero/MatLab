clear all
close all
clc

%%% Declaracao da Matriz A global
global A
global Phid Phie lbdd

%%Declaracao das constantes
%%constantes do Grupo 13





%%% Matrizes do sistema
omegaSpan = 0:0.1:1800*2*pi/60;; 
for i=1:length(omegaSpan)
    omega = omegaSpan(i);
    syms cx cy kx ky l m r
%     A = sym('A', [8 8]);
%     C = sym('C', [4 4]);
%     K = sym('K', [4 4]);
%     M = sym('M', [4 4]);
    
    M = [(mb+Jb/r^2) 0;
         0 (Je*d/l + Jm*l/d)];

    C= [b 0 0 0;
         0 2*cy 0 0;
         0 0 (2*l^2)*cy -omega*(m*r^2)/4;
         0 0 omega*(m*r^2)/4 (2*l^2)*cx];

    K = [2*kx 0 0 0;
         0 2*ky 0 0;
         0 0 (2*l^2)*ky 0;
         0 0 0 (2*l^2)*kx];

%matrizes do auto problema generalizado
    A = [C M;
         M  zeros(4)];

    format short
    Q= [-K  zeros(4);
        zeros(4) M];

    %%Vd e Ve sao as matrizes de autovetores a direita e esquerda
    %%Sd de AutoValores

    %a direita
    [Vd,Sd]=eig(Q,A);
    % A esquerda
    [Ve,Sd]=eig(Q',A');

%Ordenacao das matrizes de auto valores e autoveores
    [~,id]=sort(imag(diag(Sd)));
    id=id([5 6 7 8 4 3 2 1]);
    Sd=Sd(id,id);
    Vd=Vd(:,id);
    Ve=Ve(:,id);

    d=Ve.'*A*Vd;

%normalizacao da matriz PSI a esquerda e a direita
    Psid=Vd*d^(-1/2);
    Psie=Ve*d^(-1/2);
    %%
    %autovetores a direita
    Phid=Psid(1:4,1:4);
    
    %autovetores a esquerda
    Phie=Psie(1:4,1:4);
    %%
    
    %matriz espectral com os auto valores
    lbdd=Sd(1:4,1:4);
    omegad(:,i)= diag(imag(lbdd));

    H(i,:,:)=inv([-M*omega^2+1i*C*omega+K]);
     
end

figure (1)
plot(omegaSpan,omegad)
hold on 
plot(omegaSpan,omegaSpan,'g')
 legend('x','y','thetax','thetay')


%%
 
figure (2)
plot(omegaSpan,abs(H(:,1,1)));
hold on
plot(omegaSpan,abs(H(:,2,2)));
plot(omegaSpan,abs(H(:,3,3)));
plot(omegaSpan,abs(H(:,4,4)));

legend('x','y','thetax','thetay')

    %%
    
    
     omega1=56.6;
    omega2=80;
    omega3=138.1;
    
    C1= [2*cx 0 0 0;
         0 2*cy 0 0;
         0 0 (2*l^2)*cy -omega1*(m*r^2)/4;
         0 0 omega1*(m*r^2)/4 (2*l^2)*cx];
     C2= [2*cx 0 0 0;
         0 2*cy 0 0;
         0 0 (2*l^2)*cy -omega2*(m*r^2)/4;
         0 0 omega2*(m*r^2)/4 (2*l^2)*cx];
     C3= [2*cx 0 0 0;
         0 2*cy 0 0;
         0 0 (2*l^2)*cy -omega3*(m*r^2)/4;
         0 0 omega3*(m*r^2)/4 (2*l^2)*cx];
    
    H1(:,:)=inv([-M*omega1^2+1i*C1*omega1+K])
    H2(:,:)=inv([-M*omega2^2+1i*C2*omega2+K])
    H3(:,:)=inv([-M*omega3^2+1i*C3*omega3+K])









