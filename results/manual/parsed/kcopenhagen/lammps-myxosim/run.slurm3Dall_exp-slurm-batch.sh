#!/bin/bash
#SBATCH --job-name=myxo-sim
#SBATCH --nodes=1
#SBATCH --ntasks=9
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=75M
#SBATCH --time=23:00:00
#SBATCH --constraint=cascade,skylake

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'

module purge
module load matlab/R2020b
matlab -singleCompThread -nodisplay -nosplash -r Initial_all
module purge
module load intel/19.1.1.217
module load intel-mpi/intel/2019.7
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
srun $HOME/.local/bin/lmp_della -in in.spfr3Dall_exp
