#!/bin/bash
#FLUX: --job-name=<job
#FLUX: -c=11
#FLUX: --queue=multi
#FLUX: -t=259200
#FLUX: --urgency=16

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'

echo "Start time: $(date)"
echo "SLURM_JOB_NODELIST: $SLURM_JOB_NODELIST"
echo "hostname: $(hostname)"
echo "CUDA_VISIBLE_DEVICES: $CUDA_VISIBLE_DEVICES"
echo "Job directory: $(pwd)"
source /public/software/profile.d/apps_gromacs-2020.6.sh
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
MDRUN="gmx mdrun -nb gpu -pme gpu -bonded gpu -update gpu -gpu_id 0"
prefix=t1
$MDRUN -v -s md.tpr -deffnm ${prefix} -nsteps -1 -maxh 72
