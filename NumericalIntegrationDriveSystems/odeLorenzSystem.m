%% ODE's 
% Lorenz chaotic system
% 


function dxdt = odeLorenzSystem(t,x)
%parameters of chaotic systems
global a2 b2 c2

dxdt = zeros(3,1);

% Estados
x1 = x(1);
x2 = x(2);
x3 = x(3);


%% Sistema caótico de Lorenz

%Derivadas estados
x1punto = a2*(x2 - x1);
x2punto = b2*x1 - x1*x3 - x2;
x3punto = x1*x2 - c2*x3;

% Asignamos al vector de derivadas los estados y coestados
dxdt = [x1punto; x2punto; x3punto];
return
end
