%% Graphics of master chaotic system
% Graphics of the three chaotic systems to form a master chaotic system
% 
%%
clc; clear; clearvars; % clean memory and screen

%% Load the state variables of the three chaotic systems
load('x1Chen','x1');
load('x2Chen','x2');
load('x3Chen','x3');
load('y1Lorenz','y1');
load('y2Lorenz','y2');
load('y3Lorenz','y3');
load('z1Lu','z1');
load('z2Lu','z2');
load('z3Lu','z3');
% Load iterations
load('IterLorenz','Iter');
%%
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
% Define the three variables of the master system
v1 = alfa2.*x2.*(beta1.*y1+gamma2.*z2);
v2 = alfa1.*x1.*(beta2.*y2+gamma3.*z3);
v3 = alfa3.*x3.*(beta3.*y3+gamma1.*z1);
%% Plot the variables of master system
figure
plot(Iter', v1,'-', Iter', v2,'-.', Iter', v3,'--', LineWidth=1)
title('State variables of master system')
legend('x_2(y_1+z_2)','x_1(y_2+z_3)', 'x_3(y_3+z_1)')
%ylabel('')
xlabel('Iterations')
grid on
%
%%
% phase space of master system
figure
plot3(v1,v2,v3)
title('Chaotic master system')
xlabel('x_2(y_1+z_2)'), ylabel('x_1(y_2+z_3)'), zlabel('x_3(y_3+z_1)')
grid on

% save the variables of master system

%% save the variables of master chaotic system
savefile1 = 'vm1.mat';
savefile2 = 'vm2.mat';
savefile3 = 'vm3.mat';
%
save(savefile1, 'v1');
save(savefile2, 'v2');
save(savefile3, 'v3');