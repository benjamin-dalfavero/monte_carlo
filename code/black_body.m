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
% take only lT where concentrated
lT_conc = lT_num(and((lT_num >= 1.5e4), (lT_num <= 4e4)));
lambda_num = lT_conc / T;

%% get energy per bundle
sigma = 5.670374e-8; % stefan-boltzman constant
e = sigma * T^4 / N;

%% histrogram of wavelength distribution
nbins = 200;
histogram(lambda_num, nbins)
