function exact(fname)
% compute view factor by superposition

% read data from file
param = readtable(fname);
Dy = param.Dy;
Dz = param.Dz;
x = param.x;
y = param.y;
z = param.z;
N = param.N;
% trim area so z >=0 and solve
if (z < 0) && (Dz <= abs(z))
    % radiation does not reach below z = 0
    disp('area below dA1')
    F = 0;
elseif (z < 0) && (Dz >= abs(z))
    % modify A2 to only consider area above z = 0
    disp('A2 trimmed')
    F = solve_fac(x, y, 0, Dy, Dz - abs(z));
else % z >= 0
    disp('no change to A2')
    F = solve_fac(x, y, z, Dy, Dz);
end
% write results to file
fname_out = strrep(fname, '.csv', '_exact.csv');
fname_out = strrep(fname_out, 'param', 'exact');
fid = fopen(fname_out, 'w');
fprintf(fid, "%0.5f\n", F);
fclose(fid);
end

function F = solve_fac(x, y, z, Dy, Dz)
% solve view factor given position and dimensions
% note A2 must not extend below z = 0
% this is taken care of in main function
if (y < 0) && (Dy <= abs(y))
    disp('diagonal with y < 0')
    F = diagn(abs(y) - Dy, Dy, z, Dz, x);
elseif (y < 0) && (Dy > abs(y))
    disp('A2 straddles dA1')
    F = straddle(abs(y), Dy - abs(y), z, Dz, x);
else
    disp('diagonal with y > 0')
    F = diagn(y, Dy, z, Dz, x);
end
end

function F = diagn(w1, w2, h1, h2, Dx)
% view factor when A2 straddles z axis
F = vfac(Dx, w1+w2, h1+h2) - vfac(Dx, w1, h1+h2) ...
    - vfac(Dx, w1+w2, h1) + vfac(Dx, w1, h1);
end

function F = straddle(w1, w2, h1, h2, Dx)
% view factor when A2 is offset diagonally from dA1
F = vfac(Dx, w1, h1+h2) - vfac(Dx, w1, h1) ...
    + vfac(Dx, w2, h1+h2) - vfac(Dx, w2, h1);
end

function F = vfac(Dx, Dy, Dz)
% calculate view factor for area at corner
if (Dz == 0) || (Dy == 0) || (Dz == 0)
    F = 0;
else
    A = Dz / Dy;
    C = Dx / Dy;
    Y = sqrt(A^2 + C^2);
    F = (atan(1/C) - (C/Y)*atan(1/Y)) / (2 * pi);
end
end