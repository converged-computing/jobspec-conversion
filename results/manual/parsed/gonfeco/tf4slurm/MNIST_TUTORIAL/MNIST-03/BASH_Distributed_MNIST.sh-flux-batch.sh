#!/bin/bash
#FLUX: --job-name=purple-hobbit-2493
#FLUX: -n=4
#FLUX: -c=6
#FLUX: --queue=cola-corta
#FLUX: -t=300
#FLUX: --urgency=16

export TFSERVER=''
export GRPC_POLL_STRATEGY='poll'

TENSORFLOW=$1
echo "TENSORFLOW: "$TENSORFLOW
PYTHON=$2
echo "PYTHON: "$PYTHON 
REDHAT=$(lsb_release -a | sed -n 's/Release:\t//p')
echo "REDHAT: "$REDHAT
module purge
PATHTOPACKAGE="../../tf4slurm"
if [ $REDHAT = "6.7" ]
then
	MODULES=$(bash $PATHTOPACKAGE/ModulesForRedHat6.7.sh $TENSORFLOW $PYTHON)
else
	MODULES=$(bash $PATHTOPACKAGE/ModulesForRedHat7.5.sh $TENSORFLOW $PYTHON)
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
MEMORY=$MEMPERTASK
IB="IB"
export TFSERVER=""
if [ $IB = "NoIB" ]
  then
  #Get the IPs of all nodes of the allocated job. Ethernet IPs
  TFSERVER=$(srun -n $SLURM_NNODES --ntasks-per-node=1 $PATHTOPACKAGE/Wraper_NoIB.sh)
  else
  #Get the IPs of all nodes of the allocated job. Infiny Band IPs
  TFSERVER=$(srun -n $SLURM_NNODES --ntasks-per-node=1 $PATHTOPACKAGE/Wraper_IB.sh)
fi
echo $TFSERVER
export GRPC_POLL_STRATEGY="poll"
DATA_DIR=./MNIST_DATA_TF_$TENSORFLOW"_PYTHON_"$PYTHON
MODEL_DIR=./DISTRIBUTED_MONITORED_TF_$TENSORFLOW"_PYTHON_"$PYTHON
BATCH_SIZE=50
MAX_STEPS=1000
PS=1
WORKERS=$((SLURM_NTASKS-PS))
srun -n $SLURM_NTASKS -c $SLURM_CPUS_PER_TASK  --mem $MEMORY  --resv-ports=$SLURM_NTASKS_PER_NODE -l python LaunchTFServerWithHooks.py -ps $PS -workers $WORKERS --data_dir $DATA_DIR --model_dir $MODEL_DIR -batch_size $BATCH_SIZE -Iterations $MAX_STEPS 
