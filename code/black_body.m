%% black body radiation

%% set up constants
np = 100; % number of points in interpolation table
N = 200; % number of bundles
dat = csvread('../data/black_body.csv');
lt = dat(:, 1); % lambda * T
R = dat(:, 2); % associated CDF value

%% function to sample
% we will sample the cdf by interpolating from the given table
F = @(x) interp1(lt, R, x);

%% sample cdf
[y, xi] = sample(F, np, N);

%% plot results
plot(xi, y)
