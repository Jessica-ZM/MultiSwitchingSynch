%
%% Program for compound synchronization with optimal control
% Sychronization of Chen, Lorenz, Lu and Rossler systems as TBVP
% Numerical method: bvp4c or bvp5c

%%
clc; clear; clearvars; % clean memory and screen

% Parameters of Rossler system
global a4 b4 c4 
% variables of master system
global rint v1 v2 v3 tsim
% boundary conditions
global w1v w2v w3v
%
% Values of parameters
a4 = 0.2;
b4 = 0.2;
c4 = 5.7;
rint = 1.0e-11;
%
%% Load the state variables of the three chaotic systems
load('C:\Users\jessi\Documents\Estancia\MastersNumericalIntegration\vm1IC3','v1');
load('C:\Users\jessi\Documents\Estancia\MastersNumericalIntegration\vm2IC3','v2');
load('C:\Users\jessi\Documents\Estancia\MastersNumericalIntegration\vm3IC3','v3');
% time vector of simulation
load('C:\Users\jessi\Documents\Estancia\MastersNumericalIntegration\timesim3','tsim');
%
%% Initial conditions of slave system
w1v = 40.0;
w2v = -20.0;
w3v = 30.0;
%% Guess initial conditions for numerical method of boundary value problems
w1 = 40.0; % 
w2 = -20.0; %
w3 = 30.0; % 
%
p1 = 0;
p2 = 0;
p3 = 0;
%
%% Simulation parameters
t0 = 0;   % Initial time
condInix = [w1; w2; w3; p1; p2; p3]; % Initial vector to numerical method
tau = linspace(0,10,10001);  % dimensionless time vector
%
options = bvpset('RelTol',0.1,'AbsTol',0.1,'Stats','on','Vectorized','on');
solinit = bvpinit(tau, condInix); % Guess initial solution with bvpinit function
%
% A guess structure is created that consists of time mesh
% in the range of BCs and a guess function (Gsol1):
% SOLin1 = bvpinit(tau,@Gsol1);
% Another initial guess (with a function) Gsol2
%SOLin2 = bvpinit(tau,@Gsol2);
%%
% Call to numerical method
sol = bvp4c(@odeRossler, @bcRossler, solinit, options);
% sol = bvp4c(@odeRossler, @bcRossler, SOLin1, options);
%%
% approximation to y(t) on the points of mesh (sol.x)
y = sol.y; % return states and co-states 
%
% time
time = sol.x;
%
% Optimal controls u1, u2, u3, derived form dH/du = 0
u1 = -y(4,:)./rint;
u2 = -y(5,:)./rint;
u3 = -y(6,:)./rint;
%%
% Error
n = length(time);
e1 = zeros(n,1); e2 = zeros(n,1); e3 = zeros(n,1);
y1m = zeros(n,1); y2m = zeros(n,1); y3m = zeros(n,1);
for i = 1:n
    ref1 = spline(tsim,v1,time(i));
    ref2 = spline(tsim,v2,time(i));
    ref3 = spline(tsim,v3,time(i));
    e1(i) =  ref1 - y(1,i);
    e2(i) =  ref2 - y(2,i);
    e3(i) =  ref3 - y(3,i);
    y1m(i) = ref1;
    y2m(i) = ref2;
    y3m(i) = ref3;
end
%
%%
% vector para las iteraciones
Iter = 0: 1: n-1;
%%
% Phase space
figure
plot3(y1m,y2m,y3m,'m','linewidth',1)
hold on
plot3(y(1,:),y(2,:),y(3,:),'g--','linewidth',1)
plot3(y1m(1),y2m(1),y3m(1),'.m','markersize',30)
plot3(w1v,w2v,w3v,'.g','markersize',30)
hold off
grid on
legend('Master','Slave')
 xt = get(gca, 'XTick');
 set(gca, 'FontSize',20)
 axis tight
xlabel('\fontsize{24} \bf x_2(y_1+z_2)'), 
ylabel('\fontsize{24} \bf x_1(y_2+z_3)'), 
zlabel('\fontsize{24} \bf x_3(y_3+z_1)'),
%view(-25,9)
view(-50,15)
ax = gca;
%exportgraphics(ax,'PhaseSpaceSwith1IC2.png','Resolution',300)
%
%% State variables
figure
tiledlayout(3,1)
% 1 plot
nexttile
plot(time,y1m,'-m',time,y(1,:),'g--','linewidth',1)
grid 
legend('x_2(y_1+z_2)','w_1')
set(gca, 'FontSize', 16)
% 2 plot
nexttile
plot(time,y2m,'-m',time,y(2,:),'g--','linewidth',1)
grid 
legend('x_1(y_2+z_3)', 'w_2')
set(gca, 'FontSize', 16)
% 3 plot
nexttile
plot(time,y3m,'-m',time,y(3,:),'g--','linewidth',1)
grid 
xlabel('time')
legend('x_3(y_3+z_1)','w_3')
set(gca, 'FontSize', 16)
ax = gca;
%exportgraphics(ax,'VariableStateSwith1IC2.png','Resolution',300)
%%
figure
tiledlayout(3,1)
% 1 plot
nexttile
plot(time,e1), grid;
title('Synchronization error');
% 2 plot
nexttile
plot(time,e2), grid;
% 3 plot
nexttile
plot(time,e3), grid;
%
%%
% Relative error
% (ys - ym ) / (Max(ym) - min(ym))
%
er1 = abs(e1)/ (max(y1m)-min(y1m));
er2 = abs(e2)/ (max(y2m)-min(y2m));
er3 = abs(e3)/ (max(y3m)-min(y3m));
%
%%
% Graphs relative errors
figure
plot(time,er1), grid;
title('Relative error e_{2121}');
xlabel('time')
set(gca, 'FontSize', 12)
ax = gca;
%exportgraphics(ax,'RelativeErrorsX1Swith1IC2.png','Resolution',300)
% 2 plot
figure
plot(time,er2), grid;
title('Relative error e_{1232}');
xlabel('time')
set(gca, 'FontSize', 12)
ax = gca;
%exportgraphics(ax,'RelativeErrorsX2Swith1IC2.png','Resolution',300)
% 3 plot
figure
plot(time,er3), grid;
title('Relative error e_{3313}');
xlabel('time')
set(gca, 'FontSize', 12)
ax = gca;
%exportgraphics(ax,'RelativeErrorsX3Swith1IC2.png','Resolution',300)
%
%%
figure
plot(time,u1,'o', time, u2,'o', time,u3,'o'); grid  % control
legend ('u_1','u_2','u_3');
title('Control');
%
%%
figure
semilogy(time,er1,'+',time,er2,'+',time,er3,'+'),grid;
legend ('e_{2121}','e_{1232}','e_{3313}');
title('Relative error');
%%
% save error
savefile1 = 'IC3Error1SV2.mat';
savefile2 = 'IC3Error2SV2.mat';
savefile3 = 'IC3Error3SV2.mat';
%
save(savefile1, 'e1');
save(savefile2, 'e2');
save(savefile3, 'e3');
%
% save control
savefile4 = 'IC3Controlu1SV2.mat';
savefile5 = 'IC3Controlu2SV2.mat';
savefile6 = 'IC3Controlu3SV2.mat';
%
save(savefile4, 'u1');
save(savefile5, 'u2');
save(savefile6, 'u3');
%
% save state variables of slave system
savefile7 = 'IC3y1SlaveSV2.mat';
savefile8 = 'IC3y2SlaveSV2.mat';
savefile9 = 'IC3y3SlaveSV2.mat';
%
y1s = y(1,:);
y2s = y(2,:);
y3s = y(3,:);
save(savefile7, 'y1s');
save(savefile8, 'y2s');
save(savefile9, 'y3s');
%
% save time of synchronization
savefile10 = 'IC3TimeSynchSV2.mat';
save(savefile10, 'time');
% 
% save state variables of master system
savefile11 = 'IC3y1MasterSV2.mat';
savefile12 = 'IC3y2MasterSV2.mat';
savefile13 = 'IC3y3MasterSV2.mat';
%
save(savefile11, 'y1m');
save(savefile12, 'y2m');
save(savefile13, 'y3m');
%
% save iterations
savefile14 = 'IC3IterSynchSV2.mat';
save(savefile14, 'Iter');
%
%%
% % Other guess initial conditions
% function Ft1=Gsol1(t,~)
% % 1st guess solution function:
% Ft1=([cos(t)-sin(t), sin(t)+cos(t), cos(t)+cos(t) ,0,0,0]);
% end
%