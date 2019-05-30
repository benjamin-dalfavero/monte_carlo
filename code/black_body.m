%% black body radiation

%% set up constants
np = 100; % number of points in interpolation table
N = 200; % number of bundles
dat = csvread('../data/black_body.csv');
lt = dat(:, 1); % lambda * T
R = dat(:, 2); % associated CDF value

%% numerically invert cdf
% cdf function from interpolation table
F = @(x) interp1(lt, R, x, 'pchip', 1000);
% find interpolation points for inversion
yint = zeros(1, np); % accumulator
g = 7000; % initial guess
for n = 0:np
	yint(n+1) = newton(@(x) F(x) - (n/np), g, 1e-3);
	g = yint(n+1); % reset guess
end
% sample random points
xi = rand(1, N);
n = floor(np * xi);
u = np * xi - n;
n = n+1; % account for one based indexing in vector operations
y = yint(n) + (yint(n+1) - yint(n)).*u;

root = newton(@(x) F(x) - 1.5, 300, 1e-4)
F(root)
