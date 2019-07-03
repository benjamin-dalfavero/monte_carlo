%% black body radiation

%% read data, declare constants
% table data
dat = csvread('../data/black_body.csv');
lT = dat(:, 1); % lambda * T
F = dat(:, 2); % associated CDF value
IsT = dat(:, 3); % I / sigma T^5
I_norm = dat(:, 4); % normalized intensity
% constants
sigma = 5.670374419e-8; % W m^-2 K^-4
N = input('number of bundles: ');
T = input('temperature in K: ');
nbins = input('number of bins in distribution: ');

%% define bin edges
% planck function is concentrated 0 < lT < 4.0e4
% have nbins edges in the concentrated region, 
% last edge is max(lT)
lT_edges = linspace(0, 4.0e4, nbins);
lT_edges = [lT_edges, max(lT)];
% edges for lambda
lambda_edges = lT_edges / T;
% edges for F, corresponds to distribution of xi values
F_edges = interp1(lT, F, lT_edges);

%% sort random variable into bins
xi = rand(1, N);
[counts, F_edges] = histcounts(xi, F_edges);

%% convert bundle counts to physical quantities
% energy per bin
ebundle = sigma * T^4 / N;
energy = ebundle * counts;
% emissive power
% get midpoint wavelength of each bin
lam_mid = diff(edges);
lam_mid = [lam_mid, edges(end) - edges(end - 1)];
% dividge energy by wavelengths to get emissive power
power = energy ./ lam_mid;
% exact solution for emissive power 
IsT_exact = interp1(lt, IsT, lam_mid * T);
I_exact = IsT_exact * sigma * T^5;
Eb_exact = I_exact * pi;
% error in approximation
err = abs(power - Eb_exact);

