function exact(fname)
% compute exact results for second configuration

% read data from file
param = readtable(fname);
Dx = param.Dx;
Dy = param.Dy;
Dz = param.Dz;
x = param.x;
y = param.y;
N = param.N;
% y value for each area
yv = [y, Dy - y];
% calculate view factors and sum
F = zeros(1, length(yv));
for i = 1:length(yv)
    if yv(i) ~= 0
        A = Dz / yv(i);
        C = (Dx - x) / yv(i);
        Y = sqrt(A^2 + C^2);
        F(i) = (1 / (2 * pi)) * (atan(1/C) - (C/Y) * atan(1/Y));
    else
        F(i) = 0;
    end
end
F_ex = sum(F);
% write to file
fname_out = strrep(fname, '.csv', '_exact.csv');
fname_out = strrep(fname_out, 'param', 'exact');
fid = fopen(fname_out, 'w');
fprintf(fid, '%0.7f\n', F_ex);
fclose(fid);
end