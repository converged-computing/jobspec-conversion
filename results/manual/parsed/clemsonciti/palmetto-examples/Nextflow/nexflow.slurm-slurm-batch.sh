#!/bin/bash
#SBATCH --nodes=2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --mem=10G
#SBATCH --time=00:30:00
#SBATCH --constraint=ntasks-per-node=2

module load openjdk/17.0.8.1_1
./nextflow run 3_parallelExample.nf -c configs/slurm.config
