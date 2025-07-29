#!/bin/bash
#SBATCH --job-name=an-cockrell
#SBATCH --output=an-cockrell.out
#SBATCH --mail-user=adam.knapp@ufl.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=8gb
#SBATCH --time=7-12:00:00

pwd; hostname; date
module load python3
cd /home/adam.knapp/blue_rlaubenbacher/adam.knapp/data-assimilation/kalman/an-cockrell-abm/an-cockrell
python3 an-cockrell-runner.py
date
