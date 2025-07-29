#!/bin/bash
#SBATCH --job-name=torch_bert
#SBATCH --output=%j.out
#SBATCH --error=%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --partition=cu-1
#SBATCH --constraint=ntasks-per-node=1

l=`whoami`
CURDIR=`pwd`
NODES=`scontrol show hostnames $SLURM_JOB_NODELIST`
for i in $NODES
do
echo "$i:$SLURM_NTASKS_PER_NODE">>$CURDIR/nodelist.$SLURM_JOB_ID
done
echo $SLURM_NPROCS
echo "process will start at:"
date
module load cuda/cuda-10.2
module load pytorch/pytorch-gpu-1.10.0-py37
cd $SLURM_SUBMIT_DIR
./am_onehot_run.sh
echo "++++++++++++++++++++++++++++++++++++++++"
echo "processs will sleep 30s"
sleep 30
echo "process end at : "
date
