#!/bin/bash
#SBATCH --job-name=Antibody
#SBATCH --output=namd2.%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --time=20:00:00
#SBATCH --partition=GPUv100s
#SBATCH --constraint=ntasks-per-node=1

export CUDA_VISIBLE_DEVICES='0	# 0 for 1st GPU, 1 for 2nd GPU, 0,1 for both'
export NAMD_DIR='/home2/your_id/tools/namd2/namd2.13_gpu'
export LD_LIBRARY_PATH='$NAMD_DIR:$LD_LIBRARY_PATH'

export CUDA_VISIBLE_DEVICES=0	# 0 for 1st GPU, 1 for 2nd GPU, 0,1 for both
export NAMD_DIR="/home2/your_id/tools/namd2/namd2.13_gpu"
export LD_LIBRARY_PATH=$NAMD_DIR:$LD_LIBRARY_PATH
numCPU=$SLURM_JOB_CPUS_PER_NODE
NAMD="$NAMD_DIR/namd2 +p$numCPU +idlepoll "
$NAMD equilibration.conf > equil.log
$NAMD md.conf >md.log
