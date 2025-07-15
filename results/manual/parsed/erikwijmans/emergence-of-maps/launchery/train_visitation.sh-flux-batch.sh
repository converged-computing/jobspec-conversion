#!/bin/bash
#FLUX: --job-name=blue-nunchucks-6497
#FLUX: -c=10
#FLUX: --gpus-per-task=1
#FLUX: --queue=learnfair
#FLUX: -t=21600
#FLUX: --priority=16

export MASTER_ADDR='$(srun --ntasks=1 hostname 2>&1 | tail -n1)'

. /private/home/erikwijmans/miniconda3/etc/profile.d/conda.sh
conda deactivate
conda activate nav-analysis-base
time_offset=$((${SLURM_ARRAY_TASK_ID} - ${SLURM_ARRAY_TASK_COUNT} / 2))
if (( ${time_offset} >= 0 )); then
    time_offset=$((${time_offset} + 1))
fi
module purge
module load cuda/10.1
module load cudnn/v7.6.5.32-cuda.10.1
module load NCCL/2.5.6-1-cuda.10.1
module load openmpi/4.0.1/gcc.7.4.0-git_patch#6654
export MASTER_ADDR=$(srun --ntasks=1 hostname 2>&1 | tail -n1)
printenv | grep SLURM
set -x
srun -u \
    python -u -m nav_analysis.map_extraction.training.train_position_predictor \
    --time-offset ${time_offset} \
    --val-dataset data/map_extraction/positions_maps/loopnav-final-mp3d-blind_val-for-training.lmdb \
    --train-dataset data/map_extraction/positions_maps/loopnav-final-mp3d-blind_train.lmdb \
    --chance-run False \
    --mode "eval"
