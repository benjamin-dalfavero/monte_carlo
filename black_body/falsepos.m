function [x] = falsepos(f, x1, x2)
% [x] = falsepos(f, x1, x2)
% f - function f(x) = 0
% x1 - first x value
% x2 - second x value
% x - approximate root
% note: x1 < x < x2

% set constants
tol = 1e-4;
maxiter = 20;
% return if root is in bound
if f(x1) == 0
	x = x1;
	return
elseif f(x2) == 0
	x = x2;
	return
end
% initial guess
x = (x1*f(x2) - x2*f(x1))/(f(x2) - f(x1));
% iterate
i = 0;
while (abs(x) >= tol)
	x = (x1*f(x2) - x2*f(x1))/(f(x2) - f(x1));
	if f(x) > 0
		x2 = x;
		x1 = x1;
	else
		x2 = x2;
		x1 = x;
	end
	i = i + 1;
	% break if too many iterations
	if i >= maxiter
		break
	end
end
