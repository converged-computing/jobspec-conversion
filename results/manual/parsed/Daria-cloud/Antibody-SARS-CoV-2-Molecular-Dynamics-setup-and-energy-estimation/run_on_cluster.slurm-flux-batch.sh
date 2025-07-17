#!/bin/bash
#FLUX: --job-name=Antibody
#FLUX: --queue=GPUv100s
#FLUX: -t=72000
#FLUX: --urgency=16

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
