% flip a fair coin and record number of heads and tails

% number of heads and tails
nh = 0;
nt = 0;

N = 100; % number of trials

% make flips and record values
for n = 1:N
	rflip = rand();
	if rflip > 0.5
		nh = nh + 1;
	else
		nt = nt + 1;
	end
	fprintf("%3d %0.3f %d %d\n", n, rflip, nh, nt)
end
