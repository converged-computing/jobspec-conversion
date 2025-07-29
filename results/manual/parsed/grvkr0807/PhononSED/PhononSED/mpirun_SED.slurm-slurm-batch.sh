#!/bin/bash
#SBATCH --error=err_%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=24
#SBATCH --cpus-per-task=1
#SBATCH --time=100-00:00:00
#SBATCH --nodelist=node02

export OMP_NUM_THREADS='1'

module purge
module load mpi/openmpi-x86_64
export OMP_NUM_THREADS=1
cd $SLURM_SUBMIT_DIR
mpirun -n $SLURM_NTASKS -x OMP_NUM_THREADS -wdir $SLURM_SUBMIT_DIR ./PhononSED.x > SED_$SLURM_JOBID.out
