#!/bin/bash
#FLUX: --job-name=bumfuzzled-blackbean-7568
#FLUX: -c=2
#FLUX: -t=86400
#FLUX: --urgency=16

ml py-tensorflow/2.6.2_py36
module load gcc/10.1.0
./simulate -s TORUS --pmin 0 --pmax 0.15 --Np 30 -n 10000 --Lmin 3 --Lmax 21 -v 1 --fname 'results/${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID}.out'
echo "----------------------------------"
echo "id:" "$SLURM_ARRAY_JOB_ID" "$SLURM_ARRAY_TASK_ID"
echo "cpu per task" "$SLURM_CPUS_PER_TASK"
echo "nodelist" "$SLURM_JOB_NODELIST"
echo "cluster name:" "$SLURM_CLUSTER_NAME"
