#!/bin/bash
#SBATCH --output=%x_%j.out
#SBATCH --error=%x_%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=4000
#SBATCH --time=00:15:00
#SBATCH --partition=serial_requeue

module load matlab/R2018b-fasrc01
matlab -nojvm -batch 'try, run("./hello.m"), catch, exit(1), end, exit(0)' 
