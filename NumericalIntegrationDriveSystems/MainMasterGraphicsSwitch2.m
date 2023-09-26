%% Graphics of master chaotic system
% Graphics of the three chaotic systems to form a master chaotic system
% 
%%
clc; clear; clearvars; % clean memory and screen
%
%% Load the state variables of the three chaotic systems
load('x1Chen3','x1');
load('x2Chen3','x2');
load('x3Chen3','x3');
load('y1Lorenz3','y1');
load('y2Lorenz3','y2');
load('y3Lorenz3','y3');
load('z1Lu3','z1');
load('z2Lu3','z2');
load('z3Lu3','z3');
% Load iterations
load('IterLorenz3','Iter');
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
s1 = alfa1.*x1.*(beta3.*y3+gamma2.*z2);
s2 = alfa3.*x3.*(beta2.*y2+gamma3.*z3);
s3 = alfa2.*x2.*(beta1.*y1+gamma1.*z1);
%% Plot the variables of master system
figure
plot(Iter', s1,'-', Iter', s2,'-.', Iter', s3,'--', LineWidth=1)
title('State variables of master system')
legend('x_1(y_3+z_2)','x_3(y_2+z_3)', 'x_2(y_1+z_1)')
%ylabel('')
xlabel('Iterations')
grid on
%
%%
% phase space of master system
figure
plot3(s1,s2,s3)
%title('Chaotic master system')
xlabel('\fontsize{24} \bf x_1(y_3+z_2)'), ylabel('\fontsize{24} \bf x_3(y_2+z_3)'), zlabel('\fontsize{24} \bf x_2(y_1+z_1)')
grid on
set(gca, 'FontSize', 20)
ax = gca;
%exportgraphics(ax,'IC3PhaseSpaceSwith2.png','Resolution',300)

%% save the variables of master chaotic system
savefile1 = 'sm1IC3.mat';
savefile2 = 'sm2IC3.mat';
savefile3 = 'sm3IC3.mat';
%
save(savefile1, 's1');
save(savefile2, 's2');
save(savefile3, 's3');