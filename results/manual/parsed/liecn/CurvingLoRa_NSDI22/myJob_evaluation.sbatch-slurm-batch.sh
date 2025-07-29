#!/bin/bash
#SBATCH --job-name=myJobName
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=8G
#SBATCH --time=12:59:00
#SBATCH --constraint=[intel16|intel18|amd20]
#SBATCH --licenses=matlab@27000@lm-01.i:1

cd $SLURM_SUBMIT_DIR                            # go to the directory where this job is submitted
matlab -nodisplay -r "addpath(genpath('./.'));cd 3_deployment/outdoor_emulation;main_outdoor"
scontrol show job ${SLURM_JOBID}
