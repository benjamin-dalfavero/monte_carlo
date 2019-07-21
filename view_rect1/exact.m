function exact(fname)
% exact.m - use superposition and exact expression to calculate the view
% factor for given configuration

% read file to get parameters
param = readtable(fname);
Dx = param.Dx;
Dy = param.Dy;
Dz = param.Dz;
x = param.x;
y = param.y;
N = param.N;
% solve case-by-case with superposition (see document)
if (x == 0) && (y == 0) % corner at origin
    F = vfac(Dx, Dy, Dz);
elseif (x < 0) && (y < 0) % A2 over dA1
    F = over(abs(x), Dx-abs(x), abs(y), Dy-abs(y), Dz);
else % A2 in space
    F = diagn(x, Dx, y, Dy, Dz);
end
% write result to file
fname_out = strrep(fname, '.csv', '_exact.csv');
fname_out = strrep(fname_out, 'tests', 'exact');
fid = fopen(fname_out, 'w');
fprintf(fid, '%0.5f\n', F);
fclose(fid);
end

function F = vfac(Dx, Dy, Dz)
% calculate view factor for simple configuration
if (Dx == 0) || (Dy == 0)
    F = 0;
else
    A = Dx / Dz;
    B = Dy / Dz;
    A_rad = sqrt(1 + A^2);
    B_rad = sqrt(1 + B^2);
    F = (A / A_rad * atan(B / A_rad) + B / B_rad * atan(A / B_rad)) / (2 * pi);
end
end

function F = over(w1, w2, h1, h2, Dz)
% computer view factor for A2 over dA1
F = vfac(w1, h1, Dz) + vfac(w2, h1, Dz) + vfac(w1, h2, Dz) + vfac(w2, h2, Dz);
end

function F = diagn(w1, w2, h1, h2, Dz)
% view factor for A2 diagonally offset from dA1
F = vfac(w1+w2, h1+h2, Dz) - vfac(w1+w2, h1, Dz) ...
    - vfac(w1, h1+h2, Dz) + vfac(w1, h1, Dz);
end