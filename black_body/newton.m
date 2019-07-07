function [x] = newton(f, x0, tol)
% [x] = newton(f, x0, tol)
% solve for the roots of a function
% x - approximate root
% f - function to be solved f(x) = 0
% x0 - initial guess
% tol - tolerance of solver

x = x0; % current guess
% use finite difference to approximate derivative
h = 1e-4; 
fp = (f(x+h) - f(x)) / h;
% get next guess
xn = x - (f(x) / fp);
while abs(x - xn) > tol
	x = xn;
	fp = (f(x+h) - f(x)) / h;
	xn = x - (f(x) / fp);
end
x = xn;
end
