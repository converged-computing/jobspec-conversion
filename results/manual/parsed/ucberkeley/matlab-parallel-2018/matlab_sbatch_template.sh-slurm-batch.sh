#!/bin/bash
#SBATCH --job-name=test
#SBATCH --account=fc_paciorek
#SBATCH --nodes=1
#SBATCH --ntasks=40
#SBATCH --cpus-per-task=1
#SBATCH --time=00:30:00

export MDCE_OVERRIDE_EXTERNAL_HOSTNAME='$(/bin/hostname -f)'

module load matlab
export MDCE_OVERRIDE_EXTERNAL_HOSTNAME=$(/bin/hostname -f)
matlab -nodisplay -nosplash -nodesktop < helloworld_parallel.m
