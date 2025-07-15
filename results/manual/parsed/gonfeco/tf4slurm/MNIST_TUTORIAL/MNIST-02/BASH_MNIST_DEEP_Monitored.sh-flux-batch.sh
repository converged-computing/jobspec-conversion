#!/bin/bash
#FLUX: --job-name=crunchy-earthworm-5516
#FLUX: --priority=16

TENSORFLOW=$1
echo "TENSORFLOW: "$TENSORFLOW
PYTHON=$2
echo "PYTHON: "$PYTHON 
REDHAT=$(lsb_release -a | sed -n 's/Release:\t//p')
echo "REDHAT: "$REDHAT
module purge
if [ $REDHAT = "6.7" ]
then
	MODULES=$(bash ../../tf4slurm/ModulesForRedHat6.7.sh $TENSORFLOW $PYTHON)
else
	MODULES=$(bash ../../tf4slurm/ModulesForRedHat7.5.sh $TENSORFLOW $PYTHON)
fi
echo "Here We go!!"
module load $MODULES
echo SLURM_NTASKS: $SLURM_NTASKS  
echo SLURM_CPUS_PER_TASK: $SLURM_CPUS_PER_TASK 
echo SLURM_NNODES: $SLURM_NNODES
echo SLURM_NTASKS_PER_NODE: $SLURM_NTASKS_PER_NODE
MEMPERCORE=$(eval $(scontrol show partition $SLURM_JOB_PARTITION -o);echo $DefMemPerCPU)
if [ -z "$MEMPERCORE" ]
  then
  #exclusive partitions
  MEMPERCORE=$(( $(sinfo -e -p $SLURM_JOB_PARTITION -o "%m/%c" -h) ))
fi
echo MEMPERCORE: $MEMPERCORE
MEMPERTASK=$(( $MEMPERCORE*$SLURM_CPUS_PER_TASK )) 
echo "RAM-PER-TASK: "$MEMPERTASK
MEMORY=10G
DATA_DIR=./MNIST_DATA_TF_$TENSORFLOW"_PYTHON_"$PYTHON
MODEL_DIR=./SINGLE_MONITORED_TF_$TENSORFLOW"_PYTHON_"$PYTHON
BATCH_SIZE=50
MAX_STEPS=1000
srun -n 1 -c $SLURM_CPUS_PER_TASK --mem $MEMORY python DeepMNIST_MonitoredSession.py --data_dir $DATA_DIR --model_dir $MODEL_DIR -batch_size $BATCH_SIZE -Iterations $MAX_STEPS > Log_MonitoredSessionTF_$TENSORFLOW"_PYTHON_"$PYTHON".txt"
