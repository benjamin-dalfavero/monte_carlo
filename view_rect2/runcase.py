#!/usr/bin/env python

# runcase.py - run matlab scripts and plot results

import pandas as pd
import matplotlib.pyplot as plt
import sys
import os

# get name of input file from command line arguments
fname = sys.argv[1]
# quote to be compatible with bash
quoted_fname = "'\"" + fname + "\"'"

# run monte carlo program and get data from output file
os.system("matrun case2 %s" % quoted_fname)
fname_res = fname.replace('.csv','_out.csv').replace('param','results')
data = pd.read_csv(fname_res)
F = data.F
n = data.n

# run exact solution program and get value
os.system("matrun exact %s" % quoted_fname)
fname_exact = fname.replace('.csv','_exact.csv').replace('param','exact')
file = open(fname_exact, 'r')
F_ex = float(file.read())

# read data from parameter file to generate plot title
pdat = pd.read_csv(fname)
ttl = r"%0.1f $\times$ %0.1f at (%0.1f, %0.1f, %0.1f)" % (pdat.Dy, pdat.Dz, pdat.x, pdat.y, pdat.z)

# graph results and save in directory
# plot data from results file
plt.plot(n, F)
# plot dashed line for exact value
plt.plot([0, max(n)], [F_ex, F_ex], '--r')
# labels
plt.xlabel('Bundles')
plt.ylabel(r'$F_{12}$')
plt.title(ttl)
# generate filename and save
fname_plot = fname.replace('.csv','.jpg').replace('param','plots')
plt.savefig(fname_plot)