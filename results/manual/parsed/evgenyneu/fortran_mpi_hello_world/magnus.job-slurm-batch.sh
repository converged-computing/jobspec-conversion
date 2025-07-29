#!/bin/bash
#SBATCH --job-name=hello_mpi_01
#SBATCH --account=ew6
#SBATCH --mail-user=sausageskin@gmail.com
#SBATCH --mail-type=ALL
#SBATCH --nodes=2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:00:10
#SBATCH --constraint=ntasks-per-node=24

module swap PrgEnv-gnu PrgEnv-intel
module swap PrgEnv-cray PrgEnv-intel
srun --export=all ./build/hello_mpi
