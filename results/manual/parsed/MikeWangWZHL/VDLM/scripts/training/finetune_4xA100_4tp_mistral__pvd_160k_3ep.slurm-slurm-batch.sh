#!/bin/bash
#SBATCH --job-name=finetune_4xA100_4tp__pvd
#SBATCH --account=your account
#SBATCH --output=logs/%j.%N.finetune_4xA100_4tp.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=64
#SBATCH --mem=208G
#SBATCH --time=18:00:00
#SBATCH --partition=gpuA100x4
#SBATCH: --exclusive
#SBATCH --constraint=ntasks-per-node=1,scratch&projects
#SBATCH: --no-requeue

module reset # drop modules and explicitly load the ones needed
             # (good job metadata and reproducibility)
             # $WORK and $SCRATCH are now set
module list  # job documentation and metadata
echo "job is starting on `hostname`"
WORK_DIR=`pwd`
IMAGE="path to the docker image" 
echo "WORK_DIR=$WORK_DIR"
echo "IMAGE=$IMAGE"
WANDB_API_KEY="your wandb api key"
HUGGING_FACE_HUB_TOKEN="your hugging face hub token"
echo "WANDB_API_KEY=$WANDB_API_KEY"
echo "HUGGING_FACE_HUB_TOKEN=$HUGGING_FACE_HUB_TOKEN"
SCRIPT_TO_RUN=$1
echo "SCRIPT_TO_RUN=$SCRIPT_TO_RUN"
if [ ! -f "$SCRIPT_TO_RUN" ]; then
    echo "Script $SCRIPT_TO_RUN does not exist"
    exit 1
fi
apptainer run --nv \
    --no-home \
    --no-mount bind-paths \
    --cleanenv \
    --env "HUGGING_FACE_HUB_TOKEN=$HUGGING_FACE_HUB_TOKEN" \
    --env "WANDB_API_KEY=$WANDB_API_KEY" \
    --writable-tmpfs \
    --bind $WORK_DIR:/workspace \
    $IMAGE \
    /bin/bash -c "cd /workspace && $SCRIPT_TO_RUN"
