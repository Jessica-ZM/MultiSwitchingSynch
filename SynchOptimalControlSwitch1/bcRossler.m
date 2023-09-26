%% Rossler chaotic system: initial and boundary conditions:
%           w1(0) = 40, w2(0) = -20, w3(0) = 30
%           p1(tf)=0, p2(tf)=0; p3(tf)=0
%
function res = bcRossler(xa,pb)
%
% boundary conditions
global w1v w2v w3v

res = [ xa(1)-w1v; xa(2)-w2v; xa(3)-w3v; pb(4); pb(5); pb(6)];