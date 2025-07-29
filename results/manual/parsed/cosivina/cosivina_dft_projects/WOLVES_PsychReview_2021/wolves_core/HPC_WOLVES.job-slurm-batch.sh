#!/bin/bash
#SBATCH --job-name=matlab-WOLVES_job
#SBATCH --output=matlab-WOLVES-%j.out
#SBATCH --error=matlab-WOLVES-%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=40GB
#SBATCH --time=4-00:00:00
#SBATCH --partition=ib-24-96
#SBATCH --qos=ib

module add matlab/2020a
matlab -nodisplay -nosplash -singleCompThread -r XSIT_Manual_run
