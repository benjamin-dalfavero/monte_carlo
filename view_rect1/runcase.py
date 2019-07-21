#!/usr/bin/env python

# runcase.py - run a view factor simulation given paramters

import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import os
import sys

# get name of input file from command line arguments
fname = sys.argv[1]
# quote to be compatible with bash
quoted_fname = "'\"" + fname + "\"'"

# run monte carlo program and get data from output file
os.system("matrun case1 %s" % quoted_fname)
fname_res = fname.replace('.csv','_out.csv').replace('tests','results')
data = pd.read_csv(fname_res)
F = data.F
n = data.n 

# run exact solution program and get value
os.system("matrun exact %s" % quoted_fname)
fname_exact = fname.replace('.csv','_exact.csv').replace('tests','exact')
file = open(fname_exact, 'r')
F_ex = float(file.read())

# read data from parameter file to generate plot title
pdat = pd.read_csv(fname)
ttl = r"$A_2$ %0.1f x %0.1f x %0.1f, $dA_1$ at (%0.1f, %0.1f)" \
    % (pdat.Dx, pdat.Dy, pdat.Dz, pdat.x, pdat.y)

# graph results and save in directory
# plot data from results file
plt.plot(n, F)
# plot dashed line for exact value
plt.plot([0, max(n)], [F_ex, F_ex], '--')
# labels
plt.xlabel('Bundles')
plt.ylabel(r'$F_{12}$')
plt.title(ttl)
# generate filename and save
fname_plot = fname.replace('.csv','.jpg').replace('tests','plots')
plt.savefig(fname_plot)