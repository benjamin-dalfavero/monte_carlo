function [y, xi] = sample(F, ny, nxi, g)
% [y, xi] = sample(F, ny, nxi, g)
% sample a cdf
% y - array of sampled points
% xi - random points solved for
% F - function handle of CDF
% ny - number of points for inerpolation table
% nxi - number of random points to sample
% g - initial guess for root finder

% generate inerpolation table
yint = zeros(1, ny); % accumulator for interpolation points
tol = 1e-4; % tolerance
for nn = 0:ny
	yint(nn+1) = newton(@(x) F(x) - (nn/ny), g, tol);
	g = yint(nn+1); % reset guess
end
% sample random points by interpolating inverse
xi = rand(1, nxi);
n = floor(ny * xi); % array of indices
u = ny * xi - n;
n = n+1; % account for 1-based indexing
y = yint(n) + (yint(n+1) - yint(n)).*u;
end
