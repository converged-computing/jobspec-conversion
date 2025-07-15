#!/bin/bash
#FLUX: --job-name=mlh_baseline_downstream_both_mura
#FLUX: -c=4
#FLUX: -t=3600
#FLUX: --priority=16

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK;'
export PATH='/scratch/csp9835/penv/bin:$PATH;'

experiment_config=$1
cd /scratch/$USER/MLH_Fall22/;
mkdir -p slurm/jobs;
module purge;
module load anaconda3/2020.07;
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK;
source /share/apps/anaconda3/2020.07/etc/profile.d/conda.sh;
conda activate /scratch/csp9835/penv/;
export PATH=/scratch/csp9835/penv/bin:$PATH;
python experiment.py --experiment $experiment_config
