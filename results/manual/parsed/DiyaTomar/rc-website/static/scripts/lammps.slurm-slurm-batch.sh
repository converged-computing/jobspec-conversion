#!/bin/bash
#SBATCH --account=my_acct
#SBATCH --output=thermo.out
#SBATCH --nodes=2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=3-00:00:00
#SBATCH --constraint=ntasks-per-node=40

module purge
module load intel lammps
srun lmp_iimpi -in run.in.npt
