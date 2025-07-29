#!/bin/bash
#SBATCH --account=my_acct
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:a100:2
#SBATCH --time=3-00:00:00
#SBATCH --constraint=ntasks-per-node=2

module purge
module load goolf lammps/2Aug2023
srun lmp -in run.in.npt
