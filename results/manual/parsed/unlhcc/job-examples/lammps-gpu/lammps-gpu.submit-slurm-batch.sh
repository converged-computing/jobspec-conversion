#!/bin/bash
#SBATCH --job-name=lammps_gpu_example
#SBATCH --output=lammps_job.%J.out
#SBATCH --error=lammps_job.%J.err
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu
#SBATCH --mem-per-cpu=1G
#SBATCH --time=00:15:00

module load compiler/gcc/10 openmpi/4.0 lammps-gpu/29Sep2021
mpirun lmp -sf gpu -in in_adapt.lmp
