%% ODE's 
% Lorenz chaotic system
% 
function dxdt = odeChaoticSystems(t,x)
%parameters of chaotic systems
global a1 b1 c1 a2 b2 c2 a3 b3 c3 a4 b4 c4
global alfa1 alfa2 alfa3 beta1 beta2 beta3 gamma1 gamma2 gamma3
global delta1 delta2 delta3



dxdt = zeros(12,1);

% Estados
% Chen
x1 = x(1);
x2 = x(2);
x3 = x(3);
% Lorenz
y1 = x(4);
y2 = x(5);
y3 = x(6);
% Lu
z1 = x(7);
z2 = x(8);
z3 = x(9);
% Rossler
w1 = x(10);
w2 = x(11);
w3 = x(12);
%% Master Chaotic systems
% Chen chaotic system
x1punto = a1*(x2-x1);
x2punto = ((c1-a1)*x1 - x1*x3 + c1*x2);
x3punto = (x1*x2 - b1*x3);

% Lorenz
y1punto = a2*(y2 - y1);
y2punto = b2*y1 - y1*y3 - y2;
y3punto = y1*y2 - c2*y3;

% Lu chaotic system
z1punto = a3*(z2 - z1);
z2punto = b3*z2 - z1*z3;
z3punto = z1*z2 - c3*z3;

%% Control u
phi1 = alfa2*((c1-a1)*x1 - x1*x3 + c1*x2)*(beta1*y1 + gamma2*z2) + ...
       alfa2*x2*(beta1*a2*(y2-y1) + gamma2*(b3*z2-z1*z3));
phi2 = alfa1*a1*(x2-x1)*(beta2*y2 + gamma3*z3) + alfa1*x1*(beta2*(b2*y1...
       -y1*y3 -y2) + gamma3*(z1*z2 - c3*z3));
phi3 = alfa3*(x1*x2 - b1*x3)*(beta3*y3 + gamma1*z1) + alfa3*x3*(beta3*...
       (y1*y2 - c2*y3) + gamma1*a3*(z2-z1));
u1 = 1/delta1*phi1 + (w2 + w3) + 1/delta1*(alfa2*x2*(beta1*y1 +...
       gamma2*z2)-delta1*w1) + a1/delta1*(alfa1*x1*(beta2*y2 + gamma3*z3)...
       -delta2*w2) - a2/delta1*(alfa3*x3*(beta3*y3 + gamma1*z1)-delta3*w3);
u2 = 1/delta2*phi2 -(w1 + a4*w2) + 1/delta2*(alfa1*x1*(beta2*y2+ ...
       gamma3*z3) - delta2*w2) - a1/delta2*(alfa2*x2*(beta1*y1 + gamma2*z2)...
       - delta1*w1) + a3/delta2*(alfa3*x3*(beta3*y3 + gamma1*z1) - delta3*w3);
u3 = 1/delta3*phi3 - (w3*(w1-c4) + b4) + 1/delta3*(alfa3*x3*(beta3*y3...
       + gamma1*z1) - delta3*w3) + a2/delta3*(alfa2*x2*(beta1*y1 + gamma2*z2)...
       - delta1*w1) - a3/delta3*(alfa1*x1*(beta2*y2 + gamma3*z3) - delta2*w2);
%% Slave chaotic system
% Chaotic Rossler system
w1punto = -(w2 + w3) + u1;
w2punto = w1 + a4*w2 + u2;
w3punto = w3*(w1-c4) + b4 + u3;

% Asignamos al vector de derivadas los estados y coestados
dxdt = [x1punto; x2punto; x3punto; y1punto; y2punto; y3punto; z1punto; ...
        z2punto; z3punto; w1punto; w2punto; w3punto];
return
end
