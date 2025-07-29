#!/bin/bash
#SBATCH --output=hill_slurm/hill-slurm-%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=20
#SBATCH --mem=20G
#SBATCH --time=00:11:59
#SBATCH --partition=short

                                           # -N 1 means all cores will be on th$
hostname
pwd
srun stdbuf -oL -eL ~/anaconda3/bin/python run.py --exp_base_name test_tenSteps \
--run_model main_climb.py --protein_len 0 --nwalkers 64 --nsteps 10 --ncores 20 --print_every 200
