%% black body radiation

%% get data from table
dat = csvread('../data/black_body.csv');
lt = dat(:, 1); % lambda * T
F = dat(:, 2); % associated CDF value
IsT = dat(:, 3); % Intensity / sigma T^5
I_norm = dat(:, 4); % normalized intensity

%% get temperature and number of bins
N = input('number of bundles: ');
T = input('temperature in K: ');
nbins = input('number of bins in distribution: ');

%% numerically invert cdf
xi = rand(1, N);
% find lambda * T for each xi and convert to lambda
lT_num = arrayfun(@(x) tablefind(lt, F, x), xi);
% take lT only where concentrated
lT_conc = lT_num(and((lT_num >= 1.5e4), (lT_num <= 4e4)));
% get wavelengths
lambda_num = lT_conc / T;

%% energy per bin
sigma = 5.670374e-8; % W m^-2 K^-4
e = sigma * T^4 / N;

%% sort into bins and give results
[bin_counts, lambda_bins] = histcounts(lambda_num, nbins);
% get energy per bin
energy_bins = e * bin_counts;
results = [lambda_bins; bin_counts; energy_bins];
filename = [num2str(T), 'K', num2str(N), 'bins.csv'];
csvwrite(filename, results)