#!/bin/bash
#FLUX: --job-name=angry-staircase-2476
#FLUX: -c=8
#FLUX: -t=302400
#FLUX: --urgency=16

nvidia-smi
module purge
module load python/3.9.6 scipy-stack
module load gcc/9.3.0
module load opencv/4.6.0
source ~/venv-py39-fl/bin/activate
saving_path=$(pwd)/results/nuimages10/yolov7/centralized
mkdir -p $saving_path
rsync -a --exclude="datasets" --exclude="results" ../fedpylot $SLURM_TMPDIR
mkdir -p $SLURM_TMPDIR/fedpylot/datasets/nuimages10
tar -xf datasets/nuimages10/client0.tar -C $SLURM_TMPDIR/fedpylot/datasets/nuimages10  # train
tar -xf datasets/nuimages10/server.tar -C $SLURM_TMPDIR/fedpylot/datasets/nuimages10   # val
cd $SLURM_TMPDIR/fedpylot
if [[ $SLURM_PROCID -eq 0 ]]; then
    bash weights/get_weights.sh yolov7
fi
python yolov7/train.py \
    --client-rank 0 \
    --epochs 150 \
    --weights weights/yolov7/yolov7_training.pt \
    --data data/nuimages10.yaml \
    --batch 32 \
    --img 640 640 \
    --cfg yolov7/cfg/training/yolov7.yaml \
    --hyp data/hyps/hyp.scratch.clientopt.nuimages.yaml \
    --workers 8 \
    --project experiments \
    --name ''
cp -r ./experiments $saving_path
