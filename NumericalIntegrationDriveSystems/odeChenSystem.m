%% ODE's
% Chen chaotic system
% 


function dxdt = odeChenSystem(t,x)
% parameters of the chaotic systems
global a1 b1 c1


dxdt = zeros(3,1);

% Estados
x1 = x(1);
x2 = x(2);
x3 = x(3);


%% Chen chaotic system
x1punto = a1*(x2-x1);
x2punto = ((c1-a1)*x1 - x1*x3 + c1*x2);
x3punto = (x1*x2 - b1*x3);

% Asignamos al vector de derivadas los estados y coestados
dxdt = [x1punto; x2punto; x3punto];
return
end
