#!/bin/bash
#SBATCH --account=dconti_624
#SBATCH --mail-user=jagoodri@usc.edu
#SBATCH --mail-type=end
#SBATCH --nodes=8
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=3GB
#SBATCH --time=20:00:00
#SBATCH --partition=epyc-64
#SBATCH --constraint=ntasks-per-node=16

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'

module purge
module load gcc/11.2.0
module load openblas/0.3.18
module load jags
module load openmpi
module load pmix
module load r/4.1.2
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
srun --mpi=pmix_v2 -n $SLURM_NTASKS Rscript --vanilla 1_1_solar_mixtures_mwas_hpc.R
