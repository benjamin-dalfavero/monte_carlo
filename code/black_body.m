%% black body radiation

%% get data from table
dat = readmatrix('../data/black_body.csv');
lt = dat(:, 1); % lambda * T
F = dat(:, 2); % associated CDF value

%% get temperature and number of bins
N = input('number of bins: ');
T = input('temperature in K: ');

%% numerically invert cdf
xi = rand(1, N);
% find lambda * T for each xi and convert to lambda
lT_num = arrayfun(@(x) tablefind(lt, F, x), xi);
lambda_num = lT_num / T;

% test that root finder works
num = interp1(lt, F, lT_num); % cdf values from numerical inversion
err = abs(num - xi); % average error in the inversion, should be small
mean_err = mean(err)
max_err = max(err)

%% sort wavelengths into historgram bins
nbins = 15;
% lambda values from table
lambda = lt / T;
% bins for histgram
lambda_hist = linspace(min(lambda), max(lambda), nbins);
% bundles for each bin
count_hist = histcounts(lambda_num, nbins);

%% get energy per bundle and get energy for each bin
sigma = 5.670374e-8; % stefan-boltzman constant
e = sigma * T^4 / N;
energy_bins = e * count_hist;

%% plot results
plot(lambda_hist, energy_bins, '--');
xlabel('\lambda (\mu m)')
ylabel('E (ergs)')
title('Energy emitted vs wavelength')
