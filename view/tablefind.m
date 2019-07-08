function [xq] = tablefind(x, y, yq)
% [xq] = tablefind(x, y, yq)
% reverse table lookup
% find a value xq such that f(xq) = yq
% x - interpolation table input
% y - interpolation table output
% yq - value to find
% xq - inverse

% set up constants
tol = 1e-4;
% give error if out of bounds
if yq < (min(y) - eps) || yq > (max(y) + eps)
	disp(['out of bounds ', num2str(yq)])
	if yq > max(y)
		disp(['max is ', num2str(max(y))])
	else
		disp(['min is ', num2str(min(y))])
	end
	xq = NaN;
	return;
end
% find bracketed interval
for i = 1:length(x)
	ylow = y(i);
	yup = y(i+1);
	xlow = x(i);
	xup = x(i+1);
	if (ylow <= yq) && (yup >= yq)
		break;
	end
end
% return if value found
if ylow == yq
	xq = xlow;
elseif yup == yq
	xq = xup;
end
% use root solver to find value
f = @(xq) interp1(x, y, xq) - yq;
xq = falsepos(f, xlow, xup);
end
