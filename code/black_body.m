%% black body radiation

%% read data, declare constants
% table data
dat = csvread('../data/black_body.csv');
lt = dat(:, 1); % lambda * T
F = dat(:, 2); % associated CDF value
IsT = dat(:, 3); % I / sigma T^5
I_norm = dat(:, 4); % normalized intensity
% constants
sigma = 5.670374419e-8; % W m^-2 K^-4
N = input('number of bundles: ');
T = input('temperature in K: ');
nbins = input('number of bins in distribution: ');

%% numerically invert cdf
xi = rand(1, N);
% find lambda * T for each xi and convert to lambda
lT_num = arrayfun(@(x) tablefind(lt, F, x), xi);
lambda_num = lT_num / T;

%% sort wavelengths into bins 
% define bins
% make nbins-1 number of linearly spaced bins in concentrated region
% planck function is concentrated from 0 < lT < 4e4
lambda_min = 0;
lambda_max = 4e4 / T;
edges_conc = linspace(lambda_min, lambda_max, (nbins-1));
% add last point to capture wavelengths outside the concentrated region
edges = [edges_conc, max(lt) / T];
% sort into bins
[counts, edges] = histcounts(lambda_num, edges);
% last edge is not needed - is endpoint of last bin
edges = edges(1 : (end-1));

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

%% write results to a table
res = [edges; counts; energy; power; Eb_exact; err]';
headings = {'wavelength', 'energy', 'power', 'Elb', 'error'};
res_table = array2table(res, 'VariableNames', headings);
filename = 'results.csv';
writetable(res_table, filename)
