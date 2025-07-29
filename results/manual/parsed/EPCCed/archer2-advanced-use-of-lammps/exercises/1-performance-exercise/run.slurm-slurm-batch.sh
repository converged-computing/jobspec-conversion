#!/bin/bash
#SBATCH --job-name=lmp_bench
#SBATCH --account=ta132
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:20:00
#SBATCH --partition=standard
#SBATCH --qos=short

export OMP_NUM_THREADS='1'
export SRUN_CPUS_PER_TASK='$SLURM_CPUS_PER_TASK'

module load lammps/15Dec2023
export OMP_NUM_THREADS=1
export SRUN_CPUS_PER_TASK=$SLURM_CPUS_PER_TASK
srun lmp -in in.ethanol -l log.out_${SLURM_TASKS_PER_NODE}
