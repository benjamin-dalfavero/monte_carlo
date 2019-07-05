#!/usr/bin/python

# analyze results from blackbody simulation

import pandas as pd
import numpy as np 
import matplotlib.pyplot as plt 

# read csv files, store to an array
for i in range(1, 5):
    # filename of data
    fname = 'trial' + str(i) + '.csv'
    # store to array of frames
    df[i-1] = pd.read_csv(fname)

# plot each trial
for i in range(0, 4):
    # fetch data from frame
    frame = df[i]
    lam = frame['wavelength']
    numerical = frame['power']
    exact = frame['Elb']
    # plot data in a figure