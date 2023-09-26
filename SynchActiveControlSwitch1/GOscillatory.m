function [tnew, saveyn2, yn2, savefn1, fn2] = GOscillatory(fname, bandera, tn, yant, yn, fant, fn, h, w)

n = length(yn);            % number of ode's
fn1 = zeros(n,1);
ynew = zeros(n,1);
fnew = zeros(n,1);
% Observe que fn = fc

nu = w * h;
nu2 = nu^2;
nu4 = nu^4;

beta1 =  (1/8) * (12.0 - 3.0 * nu2 +  nu4);
beta0 = -(1/240) * (120 + 10 * nu2 +  nu4);

if bandera == 1
    % se predice yn+1 por medio de un Euler
    ypn1 = yn + h .* fn;  % predice yn+1 con euler
    fn1 = feval(fname, tn + h, ypn1);
    yn2 = ypn1 + h .* (beta1 .* fn1 + beta0 .* fn);
    savefn1 = fn1;
    saveyn2 = yn2;
    % actualizamos
    tnew = tn + 2.0 * h;  % yn2 esta al tiempo tn2 = tn + 2h
    fn2 = feval(fname, tnew, yn2);   % derivada fn+2
    return
end

fn1 = feval(fname, tn + h, yant); % evalua fn+1, yant = saveyn2

% yn+2 = yn+1 + h(beta1*fn1 + beta0 * fn)
yn2 = yant + h .* (beta1 .* fn1 + beta0 .* fant); %fant = savefn1

% salvamos 
savefn1 = fn1;
saveyn2 = yn2;

tnew = tn + h;
fn2 = feval(fname, tnew, yn2);
end
