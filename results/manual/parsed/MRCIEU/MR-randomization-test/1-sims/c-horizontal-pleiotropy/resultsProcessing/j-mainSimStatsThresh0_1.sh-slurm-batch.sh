#!/bin/bash
#SBATCH --job-name=j-mainSimStatsThresh0_1
#SBATCH --account=ACC1234
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=100G
#SBATCH --time=06:00:00
#SBATCH --partition=veryshort
#SBATCH --constraint=ntasks-per-node=1

export RES_DIR='${HOME}/2021-randomization-test/results'

date
cd $SLURM_SUBMIT_DIR
module add languages/r/4.2.1
export RES_DIR="${HOME}/2021-randomization-test/results"
Rscript mainSimStatsThresh0_1.R
module add apps/matlab/2021a
matlab -r "resFileName='sim-res-thresh0_1';plotRes"
date
