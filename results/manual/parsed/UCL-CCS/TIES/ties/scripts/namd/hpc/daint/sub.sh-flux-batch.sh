#!/bin/bash
#FLUX: --job-name="namd"
#FLUX: -c=24
#FLUX: -t=79200
#FLUX: --priority=16

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
