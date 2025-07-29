#!/bin/bash
#SBATCH --job-name=h2o4b
#SBATCH --account=mxxxx_g
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=1
#SBATCH --gres=1
#SBATCH --time=00:10:00
#SBATCH --qos=debug
#SBATCH --constraint=gpu,ntasks-per-node=4

export SLURM_CPU_BIND='cores'

singularity
exec
docker:deepmodeling/deepmd-kit:2.2.7_cuda11.6_gpu
export SLURM_CPU_BIND="cores"
srun --mpi=pmi2 shifter --image=docker:deepmodeling/deepmd-kit:2.2.7_cuda11.6_gpu --module gpu --volume="$(pwd):/workspace" --workdir="/workspace" bash -c "./mps-wrapper.sh lmp -in in.lammps -p 4x1 -log log"
