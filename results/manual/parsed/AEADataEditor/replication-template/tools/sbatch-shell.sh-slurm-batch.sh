#!/bin/bash
#SBATCH --job-name=RunStata
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --time=00:00:30
#SBATCH --constraint=ntasks-per-node=1

/usr/local/stata16/stata-mp -b main.do
