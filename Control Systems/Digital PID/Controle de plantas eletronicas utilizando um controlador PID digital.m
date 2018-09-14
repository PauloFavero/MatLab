clear all;
clc;

s = tf('s');
G1 = -0.0986;
G2 = -2.1642/(0.0152*s + 1);
G3 = -4.723/(0.0335*s + 1);
G4 = -22.611/s;

G = G1*G2*G3*G4;

% Foto do sisotool pra provar que o C é esse ai
C = 0.25842*s^0;

F = feedback(C*G,1); 

% Tempo de estabilização
settime1 = 4/12.9;
% 12.9 é a posição dos polos dominantes com o controlador C

% O coeficiente de amortecimento csi = 1;
csi1 = 1;

% A sobreelevação calculada com aquela formula escrota = 1 tambem
sobre1 = 1 + exp((-csi1*pi)/(sqrt(1-csi1^2)));

% Resposta ao degrau e a rampa eu vo mandar por imagem
figure(1)
step(F);
rampa = 0:0.01:6;
figure(2)
lsim(F, rampa, rampa);

% Fazer a resposta ao degrau e o tempo de estabilização tão na imagem
% Resposta a rampa é fazer pelo TVF do mesmo jeito que o Johnny, só que
% com a nossa TF, que é C*G

[r,t] = gensig('square', 1, 6);

%u(t)
figure(3)
lsim(C, r, t);
u = lsim(C, r, t);

%y(t)
figure(4)
lsim(G, u, t)

%integrador
figure(5)
lsim(1/s, r, t)

% projeto de ziegler-nichols
% a partir de sisotool tem-se kosc e wosc
kosc = 4.1969;
kp = 0.6*kosc;

wosc = 44.3;
tosc = 2*pi/wosc;
ti = tosc/2;
td = tosc/8;

Czn = kp*(1 + 1/(ti*s) + td*s/(0.01*s+1));
Fzn = feedback(Czn*G, 1);

%overshoot e estabilização para degrau
figure(6)
step(Fzn);

%overshoot e estabilização para degrau
figure(7)
step(Fzn1);

pico = 1.62;
csi2 = sqrt((log(pico)^2)/(pi^2 + log(pico)^2))

%Erro de regime para entrada degrau nulo, com imagem
%Erro de regime para entrada rampa, calcular por TVF

Cz = c2d(Czn1, 0.002)

% Aqui entra o simulink

% PID a partir de sisotool
% Pegar parametros de ziegler nichols melhorado e tentar fazer um
% Parametros utilizados
% - tempo de estabilização < 0.5s
% - %overshoot < 10
% - frequencia natural < 30 rad/s
% controlador melhor

figure(8)
Csiso = 0.44*(1 + 0.043*s + (0.039*s)^2)/(s*(1 + 0.01*s));
Fsiso = feedback(Csiso*G, 1);

% Pegar overshoot e tempo de estabilização
step(Fsiso);
%Csisoz = c2d(Csiso, 0.002);

%Simulink aqui tambem