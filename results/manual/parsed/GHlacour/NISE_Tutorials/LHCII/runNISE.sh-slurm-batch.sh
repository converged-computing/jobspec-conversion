#!/bin/bash
#SBATCH --job-name=runNISE
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=2000
#SBATCH --time=05:00:00

module load intel FFTW
module load MATLAB
matlab -nodisplay < genNISEinput.m
~/git/NISE_MCFRET/NISE_2017/bin/NISE input1D
~/git/NISE_MCFRET/NISE_2017/bin/NISE inputMCFRET
~/git/NISE_MCFRET/NISE_2017/bin/NISE inputAnalyse
