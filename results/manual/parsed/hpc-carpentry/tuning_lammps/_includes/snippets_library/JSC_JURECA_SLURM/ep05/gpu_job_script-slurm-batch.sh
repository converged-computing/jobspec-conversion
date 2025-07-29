#!/bin/bash
#SBATCH --account=ecam
#SBATCH --output=mpi-out.%j
#SBATCH --error=mpi-err.%j
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:4
#SBATCH --time=00:10:00
#SBATCH --partition=develgpus
#SBATCH --constraint=ntasks-per-node=24

module purge
module use /usr/local/software/jureca/OtherStages
module load Stages/Devel-2019a
module load intel-para/2019a
module load LAMMPS/9Jan2020-cuda
srun lmp -in in.lj -sf gpu -pk gpu 4 neigh no newton off split -1.0
