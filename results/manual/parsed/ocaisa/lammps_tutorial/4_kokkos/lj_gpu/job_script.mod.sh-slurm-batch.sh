#!/bin/bash
#SBATCH --account=ecam
#SBATCH --output=mpi-out.%j
#SBATCH --error=mpi-err.%j
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=6
#SBATCH --gres=gpu:4
#SBATCH --time=00:10:00
#SBATCH --constraint=ntasks-per-node=4

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'
export OMP_PROC_BIND='spread'
export OMP_PLACES='threads'

export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
export OMP_PROC_BIND=spread
export OMP_PLACES=threads
module purge
module use /usr/local/software/jureca/OtherStages
module load Stages/Devel-2019a
module load intel-para/2019a
module load LAMMPS/3Mar2020-gpukokkos
srun lmp -in in.mod.lj -k on g 4 -sf kk -pk kokkos cuda/aware off
