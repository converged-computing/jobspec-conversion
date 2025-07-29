#!/bin/bash
#SBATCH --output=sing_test_%A.out
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=1

module purge
module load singularity
singularity exec docker://XSEDE/nix-container-sc-benchmark /usr/local/sc-benchmark/rbenchmark.R && /usr/local/sc-benchmark/scratch-dna-go 1000 1048576 10 /usr/local/sc-benchmark/dna
