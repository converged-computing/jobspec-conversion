#!/bin/bash
#SBATCH --job-name=val1_hctsa
#SBATCH --account=ot95
#SBATCH --output=logs/%x.out
#SBATCH --error=logs/%x.err
#SBATCH --mail-user=aleu6@student.monash.edu
#SBATCH --mail-type=FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=36
#SBATCH --mem=2000
#SBATCH --time=3-00:00:00
#SBATCH --constraint=ntasks-per-node=1

module load matlab/r2019b
time matlab -nodisplay -nodesktop -r "add_toolbox; main_hctsa_2_compute('HCTSA_validate1.mat'); exit"
