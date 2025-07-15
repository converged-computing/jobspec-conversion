#!/bin/bash
#FLUX: --job-name=quirky-lentil-6101
#FLUX: -c=2
#FLUX: -t=86400
#FLUX: --priority=16

export LIBRARY_PATH='$LIBRARY_PATH:~/libtensorflow2/lib'
export LD_LIBRARY_PATH='$LD_LIBRARY_PATH:~/libtensorflow2/lib'
export TF_CPP_MIN_LOG_LEVEL='3 #turn off verbosity'

ml py-tensorflow/2.6.2_py36
module load gcc/10.1.0
export LIBRARY_PATH=$LIBRARY_PATH:~/libtensorflow2/lib
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:~/libtensorflow2/lib
export TF_CPP_MIN_LOG_LEVEL=3 #turn off verbosity
prob=$(python -c "print("$SLURM_ARRAY_TASK_ID"/100.0*0.18)")
python3.6 "create_model.py" -p $prob
echo "----------------------------------"
echo "id:" "$SLURM_ARRAY_JOB_ID" "$SLURM_ARRAY_TASK_ID"
echo "cpu per task" "$SLURM_CPUS_PER_TASK"
echo "nodelist" "$SLURM_JOB_NODELIST"
echo "cluster name:" "$SLURM_CLUSTER_NAME"
