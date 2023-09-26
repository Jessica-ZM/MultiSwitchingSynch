%% Numerical Integration of Master Chen Chaotic Sytem
% Use GOscilatory,
% Special methods for oscillatories problems.
% Source: Lambert book, Gautshi methods

clc; clear; clearvars; % clean memory and screen

% parameters of the chaotic systems
global a1 b1 c1

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
a1 = 35.0;
b1 = 3.0;
c1 = 28.0;


yn = zeros(noEdos,1);         % initial conditions
yn = [0.5; 1.0; 5.0];            % Other Master
%yn = [0.01; 0.0; 0.0];            % Article
%
% auxiliary arrays of numerical methods
yant = zeros(noEdos,1);
fant = zeros(noEdos,1);

% array to save the states variables of chaotic system
ysave = zeros(noIter, noEdos);

% To calculate the derivative to start time ti
fn = odeChenSystem(ti, yn);

% Save the initial conditions
for i = 1 : noEdos
    ysave(1,i) = yn(i);
end
%% Simulation cycle
tn = ti;
for i = 1 : noIter
    % Gautschi method
    [tnew, saveyn2, yn2, savefn1, fn2] = GOscillatory(@odeChenSystem, bandera, tn, yant, yn, fant, fn, h, w);
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
% % Save state variables
savefile1 = 'x1Chen3.mat';
savefile2 = 'x2Chen3.mat';
savefile3 = 'x3Chen3.mat';
% 
x1 = ysave(:,1);
x2 = ysave(:,2);
x3 = ysave(:,3);
%
save(savefile1, 'x1');
save(savefile2, 'x2');
save(savefile3, 'x3'); 
%% Graphs
% state variable vs time
figure
plot(tsim,ysave(:,1),'b',tsim,ysave(:,2),'g',tsim,ysave(:,3),'r'); grid;
legend('x_1','x_2','x_3');
title('Chen Chaotic System ')
xlabel('time'), ylabel('State variables')
%
% state variable vs iterations
figure
plot(Iter,ysave(:,1),'b',Iter,ysave(:,2),'g',Iter,ysave(:,3),'r'); grid;
legend('x_1','x_2','x_3');
title('Chen Chaotic System ')
xlabel('Iterations'), ylabel('State variables')
%%
% phase space 
figure
plot3(ysave(:,1),ysave(:,2),ysave(:,3))
%title('Chen Chaotic System')
xlabel('\fontsize{20} \bf  x_1'), ylabel('\fontsize{20} \bf  x_2'), zlabel('\fontsize{20} \bf  x_3')
grid on
view(-15,15)
xt = get(gca, 'XTick');
 set(gca, 'FontSize',16)
 ax = gca;
exportgraphics(ax,'PhaseSpaceChen3IC.png','Resolution',300)
%%
% %% save vector of time simulation for use in synchronization
% % 
% tsim = linspace(0,tf,noIter+1);
% savefile4 = 'timesim.mat';
% save(savefile4, 'tsim');
% 
% %% Save the iterations to graphs
%  savefile5 = 'IterChen.mat';
%  save(savefile5, 'Iter');