#!/bin/bash
#FLUX: --job-name=butterscotch-pot-3493
#FLUX: -c=2
#FLUX: -t=86400
#FLUX: --priority=16

export LIBRARY_PATH='${LIBRARY_PATH}:~/libtensorflow2/lib:/moismon:/usr/lib64;\'
export LD_LIBRARY_PATH='$LD_LIBRARY_PATH:~/libtensorflow2/lib:/moismon:/usr/lib64'

export LIBRARY_PATH=${LIBRARY_PATH}:~/libtensorflow2/lib:/moismon:/usr/lib64;\
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:~/libtensorflow2/lib:/moismon:/usr/lib64
srun ./simulate -s TORUS --pmin 0.135 --pmax 0.18 --Np 25 -n 10000 --Lmin 3 --Lmax 17 -v 1 --fname "/scratch/users/ladmon/ML/results/${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID}.out" -d /scratch/users/ladmon/ML/ --dir 0  -m 'model_h,L=5(7),layer=3x128,epochs=100000,p=' --decode_with_NN --binary --cutoff 0.500005 
echo "----------------------------------"
echo "id:" "$SLURM_ARRAY_JOB_ID" "$SLURM_ARRAY_TASK_ID"
echo "cpu per task" "$SLURM_CPUS_PER_TASK"
echo "nodelist" "$SLURM_JOB_NODELIST"
echo "cluster name:" "$SLURM_CLUSTER_NAME"
