#!/usr/bin/python

# analyze results from blackbody simulation

import pandas as pd
import numpy as np 
import matplotlib.pyplot as plt 

# read csv files, store to an array
df = []
for i in range(1, 5):
    # filename of data
    fname = 'trial' + str(i) + '.csv'
    # store to array of frames
    frame = pd.read_csv(fname)
    df.append(frame)

# number of bundles used for each trial
nbundles = [750, 1000, 10000, 30000]

# plot each trial
for i in range(0, 4):
    # fetch data from frame
    frame = df[i]
    lam = frame['wavelength']
    numerical = frame['power']
    exact = frame['Elb']
    # plot data in a figure
    plt.figure(i+1)
    plt.plot(lam, numerical, '--')
    plt.plot(lam, exact, '-')
    # add titles and legends
    plt.xlabel(r"$\lambda (\mu m)$")
    plt.ylabel(r"$E_{\lambda, b} (W m^{-2} \mu m^{-1})$")
    plt.title("E with " + str(nbundles[i]) + " bundles")
    plt.legend(('Monte Carlo', 'Exact'))
    # generate filename and save figure
    fname = str(nbundles[i]) + "bundles.jpg"
    plt.savefig(fname)