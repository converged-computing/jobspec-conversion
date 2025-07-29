#!/bin/bash
#SBATCH --job-name=namd
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=24
#SBATCH --time=22:00:00
#SBATCH --constraint=ntasks-per-node=1,gpu

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'

module load daint-mc
module load NAMD/2.13-CrayIntel-19.10
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
srun namd2 +idlepoll +ppn $[SLURM_CPUS_PER_TASK-1] min.namd > min.log
srun namd2 +idlepoll +ppn $[SLURM_CPUS_PER_TASK-1] eq_step1.namd > eq_step1.log
srun namd2 +idlepoll +ppn $[SLURM_CPUS_PER_TASK-1] eq_step2.namd > eq_step2.log
srun namd2 +idlepoll +ppn $[SLURM_CPUS_PER_TASK-1] eq_step3.namd > eq_step3.log
srun namd2 +idlepoll +ppn $[SLURM_CPUS_PER_TASK-1] eq_step4.namd > eq_step4.log
srun namd2 +idlepoll +ppn $[SLURM_CPUS_PER_TASK-1] prod.namd > prod.log
