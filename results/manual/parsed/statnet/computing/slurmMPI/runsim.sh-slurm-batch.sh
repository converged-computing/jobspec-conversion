#!/bin/bash
#SBATCH --nodes=6
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=50G
#SBATCH --time=00:30:00
#SBATCH --constraint=ntasks-per-node=16

module load icc_18-ompi_1.8.8
module load r_3.2.5
mpirun -np 1 Rscript sim.R
