#!/bin/bash
#FLUX: --job-name=runNISE
#FLUX: -t=18000
#FLUX: --priority=16

module load intel FFTW
module load MATLAB
matlab -nodisplay < genNISEinput.m
~/git/NISE_MCFRET/NISE_2017/bin/NISE input1D
~/git/NISE_MCFRET/NISE_2017/bin/NISE inputMCFRET
~/git/NISE_MCFRET/NISE_2017/bin/NISE inputAnalyse
