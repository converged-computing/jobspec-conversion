#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=01:30:00
#SBATCH --constraint=ntasks-per-node=20

module load lammps-31Jan14
module load compile/intel
module load mpi/intel/openmpi-1.10.2
python $STRUCTOPT_HOME/structopt/optimizers/genetic.py structopt.in.json 
