#!/bin/bash
#FLUX: --job-name=sweep
#FLUX: -c=16
#FLUX: --queue=gpuA40x4
#FLUX: -t=172800
#FLUX: --urgency=16

export PROTOCOL_BUFFERS_PYTHON_IMPLEMENTATION='python'

module reset # drop modules and explicitly loado the ones needed
             # (good job metadata and reproducibility)
             # $WORK and $SCRATCH are now set
source ~/.bashrc
cd /projects/bbub/mjvolk3/torchcell
pwd
lscpu
nvidia-smi 
cat /proc/meminfo
module list  # job documentation and metadata
conda activate /projects/bbub/miniconda3/envs/torchcell
export PROTOCOL_BUFFERS_PYTHON_IMPLEMENTATION=python
echo "job is starting on `hostname`"
wandb artifact cache cleanup 1GB
SWEEP_FILE=experiments/smf-dmf-tmf-001/conf/deep_set-sweep_09.yaml
SWEEP_ID=$(wandb sweep $SWEEP_FILE 2>&1 | grep "Creating sweep with ID:" | awk -F': ' '{print $3}')
PROJECT_NAME=$(python torchcell/config.py $SWEEP_FILE)
echo "-----------------"
echo "SWEEP_ID: $SWEEP_ID"
echo "PROJECT_NAME: $PROJECT_NAME"
echo "-----------------"
echo "SLURM_GPUS_ON_NODE: $SLURM_GPUS_ON_NODE"
echo "SLURM_JOB_NUM_NODES: $SLURM_JOB_NUM_NODES"
echo "-----------------"
mkdir projects/bbub/mjvolk3/torchcell/experiments/smf-dmf-tmf-001/agent_log/$SWEEP_ID
for ((i=0; i<$SLURM_GPUS_ON_NODE*$SLURM_JOB_NUM_NODES; i++)); do
    (CUDA_VISIBLE_DEVICES=$i wandb agent zhao-group/$PROJECT_NAME/$SWEEP_ID > /projects/bbub/mjvolk3/torchcell/experiments/smf-dmf-tmf-001/agent_log/$SWEEP_ID/agent-$PROJECT_NAME-$SWEEP_ID$i.log 2>&1) &
done
wait
