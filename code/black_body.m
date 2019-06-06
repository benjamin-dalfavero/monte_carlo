%% black body radiation

%% set up constants
N = 100; % number of points in interpolation table
nbundles = 200; % number of bundles
dat = csvread('../data/black_body.csv');
lt = dat(:, 1); % lambda * T
R = dat(:, 2); % associated CDF value

%% numerically invert cdf
% generate y_n points
nN = linspace(0, N, N) ./ N; % values to find inverses of
yint = arrayfun(@(n) tablefind(lt, R, n), nN(1:end-1));
% solve for random points
xi = rand(1, nbundles);
n = floor(yint.*N)
