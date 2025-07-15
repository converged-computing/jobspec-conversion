#!/bin/bash
#FLUX: --job-name=outstanding-blackbean-5562
#FLUX: -c=2
#FLUX: -t=172800
#FLUX: --priority=16

module load gcc/10.1.0
./simulate -N INDEP -n 10000 --pmin 0.035 --pmax 0.055 --lmin 3 --Np 30 -v 1 --fname "/scratch/users/ladmon/422/results/${SLURM_ARRAY_JOB_ID}_$SLURM_ARRAY_TASK_ID.out"
echo "----------------------------------"
echo "id:" "$SLURM_ARRAY_JOB_ID"
echo "cpu per task" "$SLURM_CPUS_PER_TASK"
echo "nodelist" "$SLURM_JOB_NODELIST"
echo "cluster name:" "$SLURM_CLUSTER_NAME"
echo "node list:" "$SLURM_JOB_NODELIST"
echo "node list:" "$SLURM_JOB_NODELIST"
