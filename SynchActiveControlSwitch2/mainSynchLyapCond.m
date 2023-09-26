%% Synchronization of 4 chaotic systems with active control
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Source: Prajapati, Nitish, Ayub Khan, and Dinesh Khattar. 
% “On Multi Switching Compound Synchronization of Non Identical 
% Chaotic Systems.” Chinese Journal of Physics 56, no. 4 (2018): 1656–66. 
% https://doi.org/10.1016/j.cjph.2018.06.015.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Use GOscilatory,
% Special methods for oscillatories problems.
% Source: Lambert book, Gautshi methods

clc; clear; clearvars; % clean memory and screen

% parameters of the chaotic systems
global a1 b1 c1 a2 b2 c2 a3 b3 c3 a4 b4 c4
global alfa1 alfa2 alfa3 beta1 beta2 beta3 gamma1 gamma2 gamma3
global delta1 delta2 delta3
% Scalling values
alfa1 = 1;
alfa2 = 1;
alfa3 = 1;
beta1 = 1;
beta2 = 1;
beta3 = 1;
gamma1 = 1;
gamma2 = 1;
gamma3 = 1;
delta1 = 1;
delta2 = 1;
delta3 = 1;

% parameters of the simulation
ti = 0;                       % Start time
tf = 10;                     % Final time
h = 1/1000;                     % Integration step
noIter = (tf - ti) / h;       % number iterations: simulation cycle
noIter = ceil(round(noIter)); % round higher integer number
bandera = 1;                  % First step of integration method


w = 10.0;                     % frequency for numerical method
noEdos = 12;                   % number of ordinary differntial equations

% parameters of the chaotic systems
% Chen
a1 = 35.0;
b1 = 3.0;
c1 = 28.0;
% Lorenz
a2 = 10.0;
b2 = 28.0;
c2 = 8.0/3.0;
% Lu
a3 = 36.0;
b3 = 20.0;
c3 = 3.0;
% Rossler
a4 = 0.2;
b4 = 0.2;
c4 = 5.7;


yn = zeros(noEdos,1);         % initial conditions
%yn = [10.0; 10.0; 10.0];            % Master
yn = [0.5; 1.0; 5.0; 10.0; 10.0; 10.0; 12.0; 26.0; 36.0; 7; -30.0; 30.0];  % Other IC
%  yn = [0.01; 0.0; 0.0; 0.0; -0.01; 0.0; 0.0; 0.0; 0.01; 40.0; -20.0; 30.0];  % Article
%
% auxiliary arrays of numerical methods
yant = zeros(noEdos,1);
fant = zeros(noEdos,1);

% array to save the states variables of chaotic system
ysave = zeros(noIter, noEdos);

% To calculate the derivative to start time ti
fn = odeChaoticSystems(ti, yn);

% Save the initial conditions
for i = 1 : noEdos
    ysave(1,i) = yn(i);
end
%% Simulation cycle
tn = ti;
for i = 1 : noIter
    % Gautschi method
    [tnew, saveyn2, yn2, savefn1, fn2] = GOscillatory(@odeChaoticSystems, bandera, tn, yant, yn, fant, fn, h, w);
    tn = tnew;
    yant = saveyn2;
    yn = yn2;
    fant = savefn1;
    bandera = 2;
    
    % save the state variable to use after
    for j = 1 : noEdos
        ysave(i+1, j) = yn(j);
    end
end
%
%%
% time vector
tsim = linspace(0,tf,noIter+1);
% iterations vector
Iter = 0: 1: noIter;
%% Form the variables per chaotic system
x1 = ysave(:,1);
x2 = ysave(:,2);
x3 = ysave(:,3);
y1 = ysave(:,4);
y2 = ysave(:,5);
y3 = ysave(:,6);
z1 = ysave(:,7);
z2 = ysave(:,8);
z3 = ysave(:,9);
w1 = ysave(:,10);
w2 = ysave(:,11);
w3 = ysave(:,12);
%
%%
% Define the three variables of the master system
v1 = alfa1.*x1.*(beta3.*y3 + gamma2.*z2);
v2 = alfa3.*x3.*(beta2.*y2 + gamma3.*z3);
v3 = alfa2.*x2.*(beta1.*y1 + gamma1.*z1);
%
%%
% Phase space
figure
plot3(v1,v2,v3,'b','linewidth',1)
hold on
plot3(delta1.*w1,delta2.*w2,delta3.*w3,'r--','linewidth',1)
plot3(v1(1),v2(1),v3(1),'b.','markersize',30)
plot3(w1(1),w2(1),w3(1),'r.','markersize',30)
hold off
grid on
legend('Master','Slave')
 xt = get(gca, 'XTick');
 set(gca, 'FontSize',20)
 %axis tight
xlabel('\fontsize{24} \bf x_1(y_3+z_2)'), 
ylabel('\fontsize{24} \bf x_3(y_2+z_3)'), 
zlabel('\fontsize{24} \bf x_2(y_1+z_1)'),
%view(-25,9)
ax = gca;
%exportgraphics(ax,'ActivePhaseSpaceSwith2IC2.png','Resolution',300)
%% Plot the variables of master system
figure
plot(Iter', v1,'-', Iter', v2,'-.', Iter', v3,'--', LineWidth=1)
title('State variables of master system')
legend('x_1(y_3+z_2)','x_3(y_2+z_3)', 'x_2(y_1+z_1)')
%ylabel('')
xlabel('Iterations')
grid on
%
%% Error
e1 = v1 - delta1.*w1;
e2 = v2 - delta2.*w2;
e3 = v3 - delta3.*w3;
%%
% Relative error
% (ys - ym ) / (Max(ym) - min(ym))
%
er1 = abs(e1)/ (max(v1)-min(v1));
er2 = abs(e2)/ (max(v2)-min(v2));
er3 = abs(e3)/ (max(v3)-min(v3));
%
%%
% Graphics of relative error 
figure
plot(tsim,er1), grid;
ylabel('Relative error e_{1321}', LineWidth=1)
xlabel('time')
set(gca, 'FontSize', 16)
ax = gca;
% exportgraphics(ax,'RelativeErrorsX1Swith2CAIC2.png','Resolution',300)
%
figure
plot(tsim,er2), grid;
ylabel('Relative error e_{3232}', LineWidth=1)
xlabel('time')
set(gca, 'FontSize', 16)
ax = gca;
% exportgraphics(ax,'RelativeErrorsX2Swith2CAIC2.png','Resolution',300)
% 
figure
plot(tsim,er3), grid;
ylabel('Relative error e_{2113}', LineWidth=1)
xlabel('time')
set(gca, 'FontSize', 16)
ax = gca;
% exportgraphics(ax,'RelativeErrorsX3Swith2CAIC2.png','Resolution',300)
%           
%%
% Save state variables
figure
tiledlayout(3,1)
% 1 plot
nexttile
plot(tsim,v1,'-',tsim,w1,'--','linewidth',1)
grid 
legend('x_1(y_3+z_2)','w_1','Orientation','horizontal')
set(gca, 'FontSize', 16)
% 2 plot
nexttile
plot(tsim,v2,'-',tsim,w2,'--','linewidth',1)
grid 
legend('x_3(y_2+z_3)', 'w_2','Orientation','horizontal')
set(gca, 'FontSize', 16)
% 3 plot
nexttile
plot(tsim,v3,'-',tsim,w3,'--','linewidth',1)
grid 
xlabel('time')
legend('x_2(y_1+z_1)','w_3','Orientation','horizontal')
set(gca, 'FontSize', 16)
ax = gca;
% exportgraphics(ax,'VariableStateSwith2IC2.png','Resolution',300)
%
%%
%  Calculate the first iteration for which the relative error is less than 0.02 
iteraerror = zeros(8000,1);
cont = 0;
% 
    for i = 1 : length(tsim)-1
        if er1(i) > 0.02 || er2(i) > 0.02 || er3(i) > 0.02
            cont = cont +1;
            iteraerror(cont) = i;
        end
    end
    %
miter =  max(iteraerror)
tsim(miter)
%
%% Save state variables
% savefile1 = 'y1MasterLyapIC3S6.mat';
% savefile2 = 'y2MasterLyapIC3S6.mat';
% savefile3 = 'y3MasterLyapIC3S6.mat';
% % 
% save(savefile1, 'v1');
% save(savefile2, 'v2');
% save(savefile3, 'v3');
% %
% savefile4 = 'y1SlaveLyapIC3S6.mat';
% savefile5 = 'y2SlaveLyapIC3S6.mat';
% savefile6 = 'y3SlaveLyapIC3S6.mat';
% % 
% save(savefile4, 'w1');
% save(savefile5, 'w2');
% save(savefile6, 'w3');
% %
% savefile7 = 'Error1LyapIC3S6.mat';
% savefile8 = 'Error2LyapIC3S6.mat';
% savefile9 = 'Error3LyapIC3S6.mat';
% % 
% save(savefile7, 'e1');
% save(savefile8, 'e2');
% save(savefile9, 'e3');
% %
% % save simulation time
% savefile10 = 'timesimIC3S6.mat';
% save(savefile10, 'tsim');
% %
% % Save the iterations to graphs
% savefile11 = 'IterLyap1IC3S6.mat';
% save(savefile11, 'Iter');