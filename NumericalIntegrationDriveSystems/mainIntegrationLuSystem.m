%% Numerical Integration of Master Chaotic Sytem
% Use GOscilatory,
% Special methods for oscillatories problems.
% Source: Lambert book, Gautshi methods

clc; clear; clearvars; % clean memory and screen

% parameters of the chaotic systems
global a3 b3 c3

% parameters of the simulation
ti = 0;                       % Start time
tf = 10;                     % Final time
h = 1/1000;                     % Integration step
noIter = (tf - ti) / h;       % number iterations: simulation cycle
noIter = ceil(round(noIter)); % round higher integer number
bandera = 1;                  % First step of integration method


w = 10.0;                     % frequency for numerical method
noEdos = 3;                   % number of ordinary differntial equations

% parameters of the chaotic systems
a3 = 36.0;
b3 = 20.0;
c3 = 3.0;

yn = zeros(noEdos,1);         % initial conditions
yn = [12.0; 25.0; 36.0];              % Other  Master 
%yn = [0; 0.0001; 0.01];              % Other  Master 
%yn = [0.0; 0.0; 0.01];  %article
%
% auxiliary arrays of numerical methods
yant = zeros(noEdos,1);
fant = zeros(noEdos,1);

% array to save the states variables of chaotic system
ysave = zeros(noIter, noEdos);

% To calculate the derivative to start time ti
fn = odeLuSystem(ti, yn);

% Save the initial conditions
for i = 1 : noEdos
    ysave(1,i) = yn(i);
end
%% Simulation cycle
tn = ti;
for i = 1 : noIter
    % Gautschi method
    [tnew, saveyn2, yn2, savefn1, fn2] = GOscillatory(@odeLuSystem, bandera, tn, yant, yn, fant, fn, h, w);
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
%
%% Save state variables
savefile1 = 'z1Lu3.mat';
savefile2 = 'z2Lu3.mat';
savefile3 = 'z3Lu3.mat';
% 
z1 = ysave(:,1);
z2 = ysave(:,2);
z3 = ysave(:,3);
%
save(savefile1, 'z1');
save(savefile2, 'z2');
save(savefile3, 'z3');
% %
%% Graphs
% state variable vs time
figure
plot(tsim,ysave(:,1),'b',tsim,ysave(:,2),'g',tsim,ysave(:,3),'r'); grid;
legend('z_1','z_2','z_3');
title('Lu Chaotic System ')
xlabel('time'), ylabel('State variables')
%
% state variable vs iterations
figure
plot(Iter,ysave(:,1),'b',Iter,ysave(:,2),'g',Iter,ysave(:,3),'r'); grid;
legend('z_1','z_2','z_3');
title('Lu Chaotic System ')
xlabel('Iterations'), ylabel('State variables')
%
%% phase space 
figure
plot3(ysave(:,1),ysave(:,2),ysave(:,3))
%title('Lu Chaotic System')
xlabel('\fontsize{20} \bf z_1'), ylabel('\fontsize{20} \bf z_2'), zlabel('\fontsize{20} \bf z_3')
grid on
view(-15,15)
xt = get(gca, 'XTick');
 set(gca, 'FontSize',16)
 ax = gca;
 exportgraphics(ax,'PhaseSpaceLu3IC.png','Resolution',300)
%exportgraphics(ax,'PhaseSpaceLuAuthor.png','Resolution',300)
%exportgraphics(ax,'PhaseSpaceLuOther.png','Resolution',300)
%% save vector of time simulation for use in synchronization
% 
% tsim = linspace(0,tf,noIter+1);
% savefile4 = 'timesim.mat';
% save(savefile4, 'tsim');

% %% Save the iterations to graphs
%  savefile5 = 'IterLu.mat';
%  save(savefile5, 'Iter');