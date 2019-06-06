%% black body radiation

%% set up constants
N = 100; % number of points in interpolation table
nbundles = 200; % number of bundles
dat = csvread('../data/black_body.csv');
lt = dat(:, 1); % lambda * T
R = dat(:, 2); % associated CDF value

%% numerically invert cdf
% generate y_n points
nN = linspace(0, N, N-1) ./ N; % values to find inverses of
yint = arrayfun(@(n) tablefind(lt, R, n), nN);
% solve for random points
xi = rand(1, nbundles);
n = floor(xi.*N);
u = N*xi - n;
n = n+1; % adjust for array indexing
y = yint(n) + (yint(n+1) - yint(n)) .* u;

%% plot results
hold on
	plot(lt, R)
	plot(y, xi)
hold off
