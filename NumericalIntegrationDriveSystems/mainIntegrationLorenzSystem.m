%% Numerical Integration of Master Chaotic Sytem
% Use GOscilatory,
% Special methods for oscillatories problems.
% Source: Lambert book, Gautshi methods

clc; clear; clearvars; % clean memory and screen

% parameters of the chaotic systems
global a2 b2 c2

% parameters of the simulation
ti = 0;                       % Start time
tf = 10;                     % Final time
h = 1/1000;                     % Integration step
noIter = (tf - ti) / h;       % number iterations: simulation cycle
noIter = ceil(round(noIter)); % round higher integer number
bandera = 1;                  % First step of integration method


w = 1.0;                     % frequency for numerical method
noEdos = 3;                   % number of ordinary differntial equations

% parameters of the chaotic systems
a2 = 10.0;
b2 = 28.0;
c2 = 8.0/3.0;

yn = zeros(noEdos,1);         % initial conditions
yn = [10.0; 10.0; 10.0];            % Other Master
%yn = [0.0; -0.01; 0.0];            % Article
%
% auxiliary arrays of numerical methods
yant = zeros(noEdos,1);
fant = zeros(noEdos,1);

% array to save the states variables of chaotic system
ysave = zeros(noIter, noEdos);

% To calculate the derivative to start time ti
fn = odeLorenzSystem(ti, yn);

% Save the initial conditions
for i = 1 : noEdos
    ysave(1,i) = yn(i);
end
%% Simulation cycle
tn = ti;
for i = 1 : noIter
    % Gautschi method
    [tnew, saveyn2, yn2, savefn1, fn2] = GOscillatory(@odeLorenzSystem, bandera, tn, yant, yn, fant, fn, h, w);
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
savefile1 = 'y1Lorenz3.mat';
savefile2 = 'y2Lorenz3.mat';
savefile3 = 'y3Lorenz3.mat';
% 
y1 = ysave(:,1);
y2 = ysave(:,2);
y3 = ysave(:,3);
%
save(savefile1, 'y1');
save(savefile2, 'y2');
save(savefile3, 'y3');
%% Graphs
% state variable vs time
figure
plot(tsim,ysave(:,1),'b',tsim,ysave(:,2),'g',tsim,ysave(:,3),'r'); grid;
legend('y_1','y_2','y_3');
title('Lorenz Chaotic System ')
xlabel('time'), ylabel('State variables')
%
% state variable vs iterations
figure
plot(Iter,ysave(:,1),'b',Iter,ysave(:,2),'g',Iter,ysave(:,3),'r'); grid;
legend('y_1','y_2','y_3');
title('Lorenz Chaotic System ')
xlabel('Iterations'), ylabel('State variables')
%%
% phase space 
figure
plot3(ysave(:,1),ysave(:,2),ysave(:,3))
%title('Lorenz Chaotic System')
xlabel('\fontsize{20} \bf y_1'), ylabel('\fontsize{20} \bf y_2'), zlabel('\fontsize{20} \bf y_3')
grid on
view(-15,15)
xt = get(gca, 'XTick');
 set(gca, 'FontSize',16)
 ax = gca;
 exportgraphics(ax,'PhaseSpaceLorenz3IC.png','Resolution',300)
%exportgraphics(ax,'PhaseSpaceLorenzAuthor.png','Resolution',300)
%exportgraphics(ax,'PhaseSpaceLorenzOther.png','Resolution',300)
%% save vector of time simulation for use in synchronization
% 
tsim = linspace(0,tf,noIter+1);
savefile4 = 'timesim3.mat';
save(savefile4, 'tsim');

%% Save the iterations to graphs
 savefile5 = 'IterLorenz3.mat';
 save(savefile5, 'Iter');