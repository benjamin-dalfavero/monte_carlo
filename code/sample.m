function [y, xi] = sample(func, ny, nxi)
% [y, xi] = sample(func, ny, nxi)
% sample a cdf
% y - array of sampled points
% xi - random points solved for
% func - function handle of CDF
% ny - number of points for inerpolation table
% nxi - number of random points to sample

% generate inerpolation table
yint = zeros(1, ny); % accumulator for interpolation points
f = @(x, n) func(x) - n/ny; % function to find roots of for all n
g = 0.1; % initial guess
tol = 1e-7; % tolerance
for nn = 0:ny
	yint(nn+1) = newton(@(x) f(x, nn), g, tol);
	g = yint(nn+1); % reset guess
end
% sample random points by interpolating inverse
xi = rand(1, nxi);
n = floor(ny * xi); % array of indices
u = ny * xi - n;
n = n+1; % account for 1-based indexing
y = yint(n) + (yint(n+1) - yint(n)).*u;
end
