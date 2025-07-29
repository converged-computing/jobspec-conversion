#!/bin/bash
#SBATCH --job-name=lammps_test
#SBATCH --nodes=2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=12GB
#SBATCH --time=01:00:00
#SBATCH --constraint=ntasks-per-node=2,cpu_gen_genoa

module load aocc lammps
cd $SLURM_SUBMIT_DIR
srun lmp -sf omp -pk omp 8 -in in.lj.txt
