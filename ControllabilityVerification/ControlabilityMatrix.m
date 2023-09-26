%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Calculation of controllability matrix of Rossler system
%  Rossler system is
% dw1/dt = -(w2 + w3)
% dw2/dt = w1 + a4*w2
% dw3/dt = w3(w1 - c4) + b4
% where a4, b4, c4 are constants
% Date = 11 / August / 2023
% Elaborated by Jessica Zaqueros Martinez
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc; clear; clearvars; % clean memory and screen

% parameters of Rossler chaotic system
a4 = 0.2;
b4 = 0.2;
c4 = 5.7;

% Rossler system has two equilibrium points (see EqPointsRossler.nb)

% The lineal matrix of Rossler system in first equilibrium point is
A1 = [0.0 -1.0 -1.0;
    1.0 a4 0.0;
    0.035131 0.0 -5.69297;
    ];

% The lineal matrix of Rossler system in second equilibrium point is
A2 = [0.0 -1.0 -1.0;
    1.0 a4 0.0;
    28.4649 0.0 -0.0070262;
    ];

% dx/dt = Ax + Bu

% Matrix B
B = [1 0 0;
    0 1 0;
    0 0 1;
    ];

% Calculate controllability matrices
Co1 = ctrb(A1,B);
Co2 = ctrb(A2,B);
% Calculate rank of contollability matrices
rank(Co1)
rank(Co2)