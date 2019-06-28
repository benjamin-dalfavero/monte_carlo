%% black body radiation

%% get data from table
dat = csvread('../data/black_body.csv');
lt = dat(:, 1); % lambda * T
F = dat(:, 2); % associated CDF value
IsT = dat(:, 3); % I / sigma T^5
I_norm = dat(:, 4); % normalized intensity

%% get temperature and number of bins
N = input('number of bundles: ');
T = input('temperature in K: ');
nbins = input('number of bins in distribution: ');

%% numerically invert cdf
xi = rand(1, N);
% find lambda * T for each xi and convert to lambda
lT_num = arrayfun(@(x) tablefind(lt, F, x), xi);
% take lT only where planck function concentrated
lT_conc = lT_num(and((lT_num >= 0.6e3), (lT_num <= 4e4)));
% get wavelengths
lambda_num = lT_conc / T;

%% sort wavelengths into bins and give results
[bin_counts, lambda_bins] = histcounts(lambda_num, nbins);

%% convert to emissive power
% emissive power per bin
sigma = 5.670374e-8; % W m^-2 K^-4
e = sigma * T^4 / N;
Elb_num = e * bin_counts;

%% get exact solution for comparison
% convert histogram bins to wavelength temp product
lT_interp = lambda_bins * T;
% linearly interpolate to get I / sigma T^4
IsT_exact = interp1(lt, IsT, lT_interp);
% convert to emissive power
Ilb_exact = IsT_exact * sigma * T^5;
Elb_exact = pi * Ilb_exact;

%% get error in the approximation and output results
err = abs(Elb_num - Elb_exact);
results = [lambda_bins; bin_counts; Elb_num; Elb_exact; err]';
headings = {'wavelength','bundles','numerical Elb', 'exact Elb', 'error'};
results_table = array2table(results, 'VariableNames', headings);
filename = 'results.txt';
writetable(results_table, filename) 
