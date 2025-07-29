#!/bin/bash
#SBATCH --job-name=resnet_job
#SBATCH --account=<project>
#SBATCH --mail-user=<youremail@domain.org>
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=6
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem-per-cpu=55G
#SBATCH --time=00:30:00
#SBATCH --partition=m3h

export REPODIR='/scratch/<project>/$USER/gpu-examples'
export PYTHONPATH='${REPODIR}/models:$PYTHONPATH'
export DATA_DIR='${REPODIR}/M3-GPU-jobs/cifar10-data'
export MODEL_DIR='${REPODIR}/M3-GPU-jobs/single-gpu-examples/job-resnet'
export NUM_GPU='1'

module load cuda/10.1
module load cudnn/7.6.5.32-cuda10
source /path/to/miniconda/bin/activate
conda activate tf2-gpu
export REPODIR=/scratch/<project>/$USER/gpu-examples
cd $REPODIR/models
git checkout v2.1.0
export PYTHONPATH=${REPODIR}/models:$PYTHONPATH
export DATA_DIR=${REPODIR}/M3-GPU-jobs/cifar10-data
export MODEL_DIR=${REPODIR}/M3-GPU-jobs/single-gpu-examples/job-resnet
export NUM_GPU=1
python ${REPODIR}/models/official/vision/image_classification/resnet_cifar_main.py  \
    --num_gpus=$NUM_GPU  \
    --batch_size=128  \
    --model_dir=$MODEL_DIR \
    --data_dir=$DATA_DIR/cifar-10-batches-bin \
    --distribution_strategy=one_device \
EOF
