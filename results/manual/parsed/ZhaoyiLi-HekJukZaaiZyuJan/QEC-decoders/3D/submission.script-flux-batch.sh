#!/bin/bash
#FLUX: --job-name=bricky-bits-6658
#FLUX: -c=2
#FLUX: -t=172800
#FLUX: --urgency=16

module load gcc #for slac cluster
./simulate -s PLANE --pmin 0.01 --pmax 0.01 --qmin 0 --qmax 0 --Np 1 --Nq 1 -n 1000000 --lmin 3 --lmax 19 -v 1 -N INDEP --fname "/scratch/users/ladmon/3D/results/${SLURM_ARRAY_JOB_ID}_$SLURM_ARRAY_TASK_ID.out"
echo "----------------------------------"
echo "id:" "$SLURM_ARRAY_JOB_ID"
echo "cpu per task" "$SLURM_CPUS_PER_TASK"
echo "nodelist" "$SLURM_JOB_NODELIST"
echo "cluster name:" "$SLURM_CLUSTER_NAME"
echo "node list:" "$SLURM_JOB_NODELIST"
echo "node list:" "$SLURM_JOB_NODELIST"
