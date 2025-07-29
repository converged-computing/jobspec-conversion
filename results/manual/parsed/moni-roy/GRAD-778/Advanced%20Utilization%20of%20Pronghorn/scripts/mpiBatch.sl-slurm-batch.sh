#!/bin/bash
#SBATCH --job-name=myFirstMPIJob
#SBATCH --account=cpu-s5-grad_778-1
#SBATCH --output=myOutput-n1.txt
#SBATCH --mail-user=YOUREMAILHERE
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --mem=100M
#SBATCH --time=00:01:00
#SBATCH --partition=cpu-core-0

export OMP_NUM_THREADS='2'

export OMP_NUM_THREADS=2
module load openmpi/gcc/4.0.4 
module load singularity 
mpirun singularity exec lammps_latest.sif lmp_mpi < input.lammps
