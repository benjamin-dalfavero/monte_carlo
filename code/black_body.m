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

%% get energy per bundle
sigma = 5.670374e-8; % stefan-boltzman constant
e = sigma * T^4 / N;

%% histrogram of wavelength distribution
nbins = 15;
histogram(lambda_num, nbins)