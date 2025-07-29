#!/bin/bash
#SBATCH --job-name=LAMMPSAPPEKG
#SBATCH --output=lammps-%j.out
#SBATCH --error=lammps-%j.error
#SBATCH --nodes=2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:30:00
#SBATCH --exclusive

export OMP_NUM_THREADS='4'
export OMP_PLACES='cores'
export OMP_PROC_BIND='spread'

echo "good run"
module load gcc/11.2.0
module load openmpi/4.0.6
INPUT=in.ar.lj
EXEC=../../lmp_omp_appekg
export OMP_NUM_THREADS=4
export OMP_PLACES=cores
export OMP_PROC_BIND=spread
time srun --ntasks-per-node=16 --cpus-per-task=8 --cpu-bind=cores ${EXEC} -sf omp -pk omp 4 -in ${INPUT}
