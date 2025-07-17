#!/bin/bash
#FLUX: --job-name=frigid-lizard-3948
#FLUX: -c=10
#FLUX: --queue=gpu
#FLUX: -t=172800
#FLUX: --urgency=16

module load python/gpu/3.10.10
echo $SLURM_JOB_NODELIST
echo $SLURM_JOB_NUM_NODES
echo $SLURM_TASKS_PER_NODE
echo $SLURM_GPUS
nvidia-smi -L
numcpu=`grep -c processor /proc/cpuinfo`
echo "Number of CPUs: $numcpu"
mem_ask=`grep MemTotal /proc/meminfo`
echo $mem_ask
echo "GPUs located:"
lspci | grep NVIDIA
echo "CUDA_VISIBLE_DEVICES=$CUDA_VISIBLE_DEVICES"
echo "1: $1"
echo "2: $2"
echo "3: $3"
echo "4: $4"
echo "5: $5"
command_to_run="$1 $2 --inputdata $3 --config $4 --modeldir $5 --train True --device cuda --reset True"
echo "command_to_run: $command_to_run"
$command_to_run
