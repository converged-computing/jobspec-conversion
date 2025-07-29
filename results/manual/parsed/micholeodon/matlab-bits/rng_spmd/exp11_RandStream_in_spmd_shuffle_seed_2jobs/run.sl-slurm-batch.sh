#!/bin/bash
#SBATCH --job-name=RNG_TEST
#SBATCH --output=slurm-%A_%a.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=2000
#SBATCH --time=00:03:00
#SBATCH --constraint=ntasks-per-node=24
#SBATCH --array=1-2

folder=`pwd`
tstamp=`date +%d-%m-%Y_%H%M`
module load tryton/matlab/2017a
matlab -nodisplay -nodesktop -logfile $folder/logfile_${tstamp}.log  <  $folder/test_rng_cvpart.m
