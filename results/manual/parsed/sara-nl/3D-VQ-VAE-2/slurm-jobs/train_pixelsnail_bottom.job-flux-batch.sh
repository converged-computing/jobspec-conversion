#!/bin/bash
#FLUX: --job-name=pixelsnail-bottom-mixup
#FLUX: -c=6
#FLUX: --queue=gpu_titanrtx
#FLUX: -t=172800
#FLUX: --urgency=16

export OMP_NUM_THREADS='6'
export NCCL_DEBUG='INFO'
export NCCL_ASYNC_ERROR_HANDLING='1'
export PYTHONFAULTHANDLER='1'

export OMP_NUM_THREADS=6
HIERARCHY_LEVEL="2" # Should be a non-negative integer, 0 = top, 1 = mid, 2 = bottom 
DATASET_NAME="version_7446231_epoch_1214.lmdb"
CONDA_ENV="pytorch1.7"
METRIC="cross_entropy"
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
if [[ $SCRIPT_DIR == *"/var/spool/"* ]] && [ ! -z $SLURM_JOB_ID ]; then
    # When using slurm, while running a job script (instead of node salloc)
    SCRIPT_DIR=$( dirname $( scontrol show job $SLURM_JOB_ID | awk -F= '/Command=/{print $2}'))
fi
ROOT_DIR=$( cd "$SCRIPT_DIR"/..; pwd )
echo "- found root dir $ROOT_DIR"
DATASET_ROOT="$ROOT_DIR/vqvae/codes"
if [ ! -z $SLURM_JOB_NODELIST ]; then
    NODES=( $( scontrol show hostnames "$SLURM_JOB_NODELIST" | head ) )
    NUM_NODES="${#NODES[@]}"
else
    NUM_NODES="1"
fi
echo "- setting up env"
module load 2020
module load Miniconda3
module load mpicopy/4.2-gompi-2020a
module load NCCL/2.7.8-gcccuda-2020a
module load cuDNN/8.0.3.33-gcccuda-2020a
export NCCL_DEBUG=INFO
export NCCL_ASYNC_ERROR_HANDLING=1
export PYTHONFAULTHANDLER=1
echo "- activating conda env $CONDA_ENV"
source deactivate
source activate "$CONDA_ENV"
SCRIPTPATH="$ROOT_DIR/pixel-model/train.py"
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
DATASET_PATH="$DATASET_ROOT"/"$DATASET_NAME"
DATASET_INDIR="$INDIR"/"$DATASET_NAME"
echo "- assuming Dataset path $DATASET_PATH"
echo "- setting args"
PYTHON_ARGS="\
$DATASET_INDIR \
$HIERARCHY_LEVEL \
--use-model pixelsnail \
--batch-size 6 \
--metric $METRIC \
--lr "$NUM_NODES"e-4 \
--num_nodes $NUM_NODES \
--model-dim 512 \
--causal-dropout-prob 0.5 \
--attention-dropout-prob 0.0 \
--use-conditioning False \
--num-layers-per-block 5 \
--num-blocks 3 \
--mixup-alpha 0.4 \
"
echo "- found args $PYTHON_ARGS"
if (( $NUM_NODES > 1 )); then
    echo "- multi-node setup"
    echo "- copying dataset"
    mpicopy -v "$DATASET_PATH" -o $INDIR
    echo "- starting run"
    srun python "$SCRIPTPATH" $PYTHON_ARGS
else
    echo "- single-node setup"
    echo "- copying dataset"
    rsync -ah --info=progress2 "$DATASET_PATH" "$INDIR"
    echo "- starting run"
    srun python "$SCRIPTPATH" $PYTHON_ARGS
fi
