#!/bin/bash
#FLUX: --job-name=sample-embeddings-mid-lowtau
#FLUX: -c=6
#FLUX: --queue=gpu_rtx2080ti_shared
#FLUX: -t=172800
#FLUX: --urgency=16

export OMP_NUM_THREADS='6'
export NCCL_DEBUG='INFO'
export PYTHONFAULTHANDLER='1'

export OMP_NUM_THREADS=6
HIERARCHY_LEVEL="1" # Should be a non-negative integer, 0 = top, 1 = mid, 2 = bottom 
DATASET_NAME="version_7446231_epoch_1214_lowtau"
MODEL_CHECKPOINT_PATH="slurm-jobs/lightning_logs/version_7453174/checkpoints/epoch\=945-step\=100222.ckpt" # from root dir
CONDA_ENV="pytorch1.7"
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
if [[ $SCRIPT_DIR == *"/var/spool/"* ]] && [ ! -z $SLURM_JOB_ID ]; then
    # When using slurm, while running a job script (instead of node salloc)
    SCRIPT_DIR=$( dirname $( scontrol show job $SLURM_JOB_ID | awk -F= '/Command=/{print $2}'))
fi
ROOT_DIR=$( cd "$SCRIPT_DIR"/..; pwd )
echo "- found root dir $ROOT_DIR"
echo "- setting up env"
module load 2020
module load Miniconda3
module load NCCL/2.7.8-gcccuda-2020a
module load cuDNN/8.0.3.33-gcccuda-2020a
export NCCL_DEBUG=INFO
export PYTHONFAULTHANDLER=1
echo "- activating conda env $CONDA_ENV"
source deactivate
source activate "$CONDA_ENV"
SCRIPT_PATH="$ROOT_DIR/pixel-model/sample_embeddings.py"
IO_PATH="$ROOT_DIR/pixel-model/codes"/$DATASET_NAME'.pt'
CKPT_PATH="$ROOT_DIR"/"$MODEL_CHECKPOINT_PATH"
INDIR="$TMPDIR"
if [ -z $INDIR ]; then
    MAYBE_INDIR="/scratch/slurm.$SLURM_JOB_ID.0/scratch"
    if [ ! -z $SLURM_JOB_ID ] && [ -d $MAYBE_INDIR ]; then
        INDIR=$MAYBE_INDIR
    else
        echo "- INDIR is empty!"
        exit 1
    fi
fi
echo "- using INDIR $INDIR"
DATASET_PATH="$DATASET_ROOT""$DATASET_NAME""$DATASET_EXT"
DATASET_INDIR="$INDIR"/"$DATASET_NAME"
echo "- assuming Dataset path $DATASET_PATH"
echo "- setting args"
PYTHON_ARGS="\
--model-checkpoint $CKPT_PATH \
--db-path $IO_PATH \
--level $HIERARCHY_LEVEL \
--size 32 32 8 \
--num-samples 10 \
--batch-size 10 \
--tau 0.1 \
"
echo "- found args $PYTHON_ARGS"
echo "- starting run"
python "$SCRIPT_PATH" $PYTHON_ARGS
