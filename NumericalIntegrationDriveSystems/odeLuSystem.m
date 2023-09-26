%% ODE's 
% Lu chaotic system
% 

function dxdt = odeLuSystem(t,x)
%parameters of chaotic systems
global a3 b3 c3

dxdt = zeros(3,1);

% Estados
x1 = x(1);
x2 = x(2);
x3 = x(3);


%% Lu chaotic system
x1punto = a3*(x2 - x1);
x2punto = b3*x2 - x1*x3;
x3punto = x1*x2 - c3*x3;

% Asignamos al vector de derivadas los estados y coestados
dxdt = [x1punto; x2punto; x3punto];
return
end
