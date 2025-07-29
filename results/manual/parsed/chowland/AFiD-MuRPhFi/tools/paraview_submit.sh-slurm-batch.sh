#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=01:00:00
#SBATCH --exclusive

module load 2022
module load ParaView-server-osmesa/5.10.1-foss-2022a-mpi
srun pvserver --force-offscreen-rendering
