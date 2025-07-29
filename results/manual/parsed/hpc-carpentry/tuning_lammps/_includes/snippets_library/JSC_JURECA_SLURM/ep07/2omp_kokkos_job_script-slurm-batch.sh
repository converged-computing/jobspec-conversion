#!/bin/bash
#SBATCH --account=ecam
#SBATCH --output=mpi-out.%j
#SBATCH --error=mpi-err.%j
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=12
#SBATCH --time=00:10:00
#SBATCH --constraint=ntasks-per-node=2

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'
export OMP_PROC_BIND='spread'
export OMP_PLACES='threads'

module purge
module use /usr/local/software/jureca/OtherStages
module load Stages/Devel-2019a
module load intel-para/2019a
module load LAMMPS/3Mar2020-Python-3.6.8-kokkos
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
export OMP_PROC_BIND=spread
export OMP_PLACES=threads
srun lmp -in in.rhodo -k on t $OMP_NUM_THREADS -sf kk
