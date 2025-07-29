#!/bin/bash
#FLUX: --job-name=poly_graph_training
#FLUX: --queue=comm_gpu_inter
#FLUX: -t=14400
#FLUX: --urgency=16

export NUM_CORES='$((SLURM_JOB_NUM_NODES * SLURM_CPUS_ON_NODE))'

source ~/.bashrc
export NUM_CORES=$((SLURM_JOB_NUM_NODES * SLURM_CPUS_ON_NODE))
echo $SLURM_SUBMIT_DIR > log.out
if [ -n $SLURM_JOB_ID ] ; then
THEPATH=$(scontrol show job $SLURM_JOBID | awk -F= '/Command=/{print $2}')
else
THEPATH=$(realpath $0)
fi
SRC_PATH=$(dirname "${THEPATH}")
echo $SRC_PATH > log.out
module load singularity
singularity exec --nv /shared/containers/PyTorch-1.12.1-gpu-jupyter.sif python $SRC_PATH/trainer.py
