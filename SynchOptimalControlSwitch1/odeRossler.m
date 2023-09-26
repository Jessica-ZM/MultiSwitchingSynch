%% ODE's of Rossler chaotic system
% Chaotic Rossler system with co-states
% 

function dxdt = odeRossler(t,x)

% Parameters of Rossler system
global a4 b4 c4 
% variables of master system
global rint v1 v2 v3 tsim


dxdt = zeros(6,1);
%u = zeros(3,1);

ref1 = spline(tsim,v1,t);
ref2 = spline(tsim,v2,t);
ref3 = spline(tsim,v3,t);


% State
x1 = x(1,:);
x2 = x(2,:);
x3 = x(3,:);
% Co-state
p1 = x(4,:);
p2 = x(5,:);
p3 = x(6,:);

% Optimal control
u1 = -p1/rint;
u2 = -p2/rint;
u3 = -p3/rint;


%% Chaotic Rossler system

%Derivatives of the states of the system 
x1punto = -(x2 + x3) + u1;
x2punto = x1 + a4*x2 + u2;
x3punto = x3.*(x1-c4) + b4 + u3;

%Derivatives of the co-states
p1punto = -p2 + ref1 - x1 - p3.*x3;
p2punto = p1 - a4*p2 + ref2 - x2;
p3punto = p1 + ref3 - p3.*(-c4 + x1) - x3;

% vector of derivatives of states and co-states
dxdt = [x1punto; x2punto; x3punto; p1punto; p2punto; p3punto];
return
end
