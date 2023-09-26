%% Graphics of errors of synchronizations
% Graphics of optimal control
% 
%%
clc; clear; clearvars; % clean memory and screen
%
%% Load variables per synchronization
% 1st sync
% the three state variables of master system
load('IC3y1MasterSV2','y1m');
load('IC3y2MasterSV2','y2m');
load('IC3y3MasterSV2','y3m');
% the three state variables of slave system
load('IC3y1SlaveSV2','y1s');
load('IC3y2SlaveSV2','y2s');
load('IC3y3SlaveSV2','y3s');
% the erros of synchronization
load('IC3Error1SV2','e1');
load('IC3Error2SV2','e2');
load('IC3Error3SV2','e3');
% the iterations
load('IC3IterSynchSV2','Iter');
% the time 
load('IC3TimeSynchSV2','time');
% rename the variables
y11m = y1m;
y12m = y2m;
y13m = y3m;
y11s = y1s;
y12s = y2s;
y13s = y3s;
e11 = e1;
e12 = e2;
e13 = e3;
%
%%
% Obtain relative errors per synchronization
% Relative error
% (ys - ym ) / (Max(ym) - min(ym))
% 1st sync
er11 = abs(e11)/ (max(y11m)-min(y11m));
er12 = abs(e12)/ (max(y12m)-min(y12m));
er13 = abs(e13)/ (max(y13m)-min(y13m));
%
%%
figure
plot(time,er11), grid;
ylabel('Relative error e_{2121}', LineWidth=1)
xlabel('time')
set(gca, 'FontSize', 12)
ax = gca;
% exportgraphics(ax,'RelErrX1Swith1OC.png','Resolution',300)
%
figure
plot(time,er12), grid;
ylabel('Relative error e_{1232}', LineWidth=1)
xlabel('time')
set(gca, 'FontSize', 12)
ax = gca;
% exportgraphics(ax,'RelErrX2Swith1OC.png','Resolution',300)
% 
figure
plot(time,er13), grid;
ylabel('Relative error e_{3313}', LineWidth=1)
xlabel('time')
set(gca, 'FontSize', 12)
ax = gca;
% exportgraphics(ax,'RelErrX3Swith1OC.png','Resolution',300)
%    
%%
% Phase space
figure
plot3(y11m,y12m,y13m,'m','linewidth',1)
hold on
plot3(y11s,y12s,y13s,'g--','linewidth',1)
plot3(y11m(1),y12m(1),y13m(1),'.m','markersize',30)
plot3(y11s(1),y12s(1),y13s(1),'.g','markersize',30)
hold off
grid on
legend('Master','Slave')
 xt = get(gca, 'XTick');
 set(gca, 'FontSize',20)
 %axis tight
xlabel('\fontsize{24} \bf x_2(y_1+z_2)'), 
ylabel('\fontsize{24} \bf x_1(y_2+z_3)'), 
zlabel('\fontsize{24} \bf x_3(y_3+z_1)'),
%view(-25,9)
set(gca, 'FontSize', 20)
ax = gca;
%exportgraphics(ax,'IC3PhaseSpaceSwith1.png','Resolution',300)
%
%%
figure
tiledlayout(3,1)
% 1 plot
nexttile
plot(time,y11m,'-m',time,y11s,'g--','linewidth',1)
grid 
legend('x_2(y_1+z_2)','w_1','Orientation','horizontal')
set(gca, 'FontSize', 16)
% 2 plot
nexttile
plot(time,y12m,'-m',time,y12s,'g--','linewidth',1)
grid 
legend('x_1(y_2+z_3)', 'w_2','Orientation','horizontal')
set(gca, 'FontSize', 16)
% 3 plot
nexttile
plot(time,y13m,'-m',time,y13s,'g--','linewidth',1)
grid 
xlabel('time')
legend('x_3(y_3+z_1)','w_3','Orientation','horizontal')
set(gca, 'FontSize', 16)
ax = gca;
%exportgraphics(ax,'IC3VarStateSwith1.png','Resolution',300)
%
%%
%  Calculate the first iteration for which the relative error is less than 0.02 
iteraerror = zeros(8000,1);
cont = 0;
% 
    for i = 1 : length(time)-1
        if er11(i) > 0.02 || er12(i) > 0.02 || er13(i) > 0.02
            cont = cont +1;
            iteraerror(cont) = i;
        end
    end
    %
miter =  max(iteraerror)
time(miter)
%
%%
% %%
% figure 
% hold on
% ncolors = length(e11)-5;
% cmap = cool(ncolors);
% for i=2 : length(e11)-5
%     plot(e11(i-1:i),e12(i-1:i),'Color',cmap(i,:),'linewidth',1)
% end
% grid on
% hold off
% xlabel('e_{2121}')
% ylabel('e_{1232}')
% set(gca, 'FontSize', 16)
% ax = gca;
% %exportgraphics(ax,'e1e2S1.png','Resolution',300)
% %%
% figure 
% hold on
% for i=2 : length(e11)-5
%     plot(e12(i-1:i),e13(i-1:i),'Color',cmap(i,:),'linewidth',1)
% end
% grid on
% hold off
% xlabel('e_{1232}')
% ylabel('e_{3313}')
% set(gca, 'FontSize', 16)
% ax = gca;
% %exportgraphics(ax,'e2e3S1.png','Resolution',300)
% %
% %%
% figure 
% hold on
% for i=2 : length(e11)-5
%     plot(e11(i-1:i),e13(i-1:i),'Color',cmap(i,:),'linewidth',1)
% end
% grid on
% hold off
% xlabel('e_{2121}')
% ylabel('e_{3313}')
% set(gca, 'FontSize', 16)
% ax = gca;
% %exportgraphics(ax,'e1e3S1.png','Resolution',300)