#!/bin/bash
#SBATCH --job-name={Sim_Name}
#SBATCH --account=csd467
#SBATCH --output=lammpsgpu.%j.%N.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:4
#SBATCH --time=2-00:00:00
#SBATCH --partition=gpu
#SBATCH --constraint=ntasks-per-node=8
#SBATCH: --no-requeue

cd {path}
module unload mvapich2_ib
module unload intel
module load intel/2015.2.164
module load mvapich2_ib
module load cuda
ibrun -np 8 /share/apps/gpu/lammps/lmp_cuda_mpi -sf gpu -pk gpu 4 -in in.{Sim_Name} -log log.{Sim_Name}
