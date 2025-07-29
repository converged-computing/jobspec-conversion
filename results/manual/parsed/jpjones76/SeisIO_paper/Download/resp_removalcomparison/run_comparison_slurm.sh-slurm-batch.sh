#!/bin/bash
#SBATCH --job-name=RespTest
#SBATCH --output=out_resptest.dat
#SBATCH --error=err_resptest.dat
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=4000
#SBATCH --time=02:30:00
#SBATCH --constraint=ntasks-per-node=1

date
module purge
conda activate obspy
python test-ReadandRemoval_Obspy_TA.py
/n/home03/kokubo/packages/julia-1.2.0/bin/julia test-ReadandRemoval_TA.jl
echo all process has been done.
