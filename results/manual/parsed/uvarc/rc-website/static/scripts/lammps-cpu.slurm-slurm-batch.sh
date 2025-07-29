#!/bin/bash
#SBATCH --account=my_acct
#SBATCH --nodes=2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=3-00:00:00
#SBATCH --partition=parallel
#SBATCH --constraint=ntasks-per-node=40

module purge
module load goolf lammps/2Aug2023-cpu
srun lmp -in run.in.npt
