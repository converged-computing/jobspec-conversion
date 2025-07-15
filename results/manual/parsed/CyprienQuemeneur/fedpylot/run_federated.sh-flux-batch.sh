#!/bin/bash
#FLUX: --job-name=wobbly-peanut-8473
#FLUX: -N=11
#FLUX: -c=8
#FLUX: -t=43200
#FLUX: --urgency=16

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'

nvidia-smi
module purge
module load python/3.9.6 scipy-stack
module load openmpi/4.0.3
module load gcc/9.3.0
module load opencv/4.6.0
module load mpi4py
source ~/venv-py39-fl/bin/activate
saving_path=$(pwd)/results/nuimages10/yolov7/fedoptm
mkdir -p $saving_path
srun rsync -a --exclude="datasets" --exclude="results" ../fedpylot $SLURM_TMPDIR
srun mkdir -p $SLURM_TMPDIR/fedpylot/datasets/nuimages10
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
srun --cpus-per-task=$SLURM_CPUS_PER_TASK python federated/scatter_data.py --dataset nuimages10
cd $SLURM_TMPDIR/fedpylot
if [[ $SLURM_PROCID -eq 0 ]]; then
    bash weights/get_weights.sh yolov7
fi
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
srun --cpus-per-task=$SLURM_CPUS_PER_TASK python federated/main.py \
    --nrounds 30 \
    --epochs 5 \
    --server-opt fedavgm \
    --server-lr 1.0 \
    --beta 0.1 \
    --architecture yolov7 \
    --weights weights/yolov7/yolov7_training.pt \
    --data data/nuimages10.yaml \
    --bsz-train 32 \
    --bsz-val 32 \
    --img 640 \
    --conf 0.001 \
    --iou 0.65 \
    --cfg yolov7/cfg/training/yolov7.yaml \
    --hyp data/hyps/hyp.scratch.clientopt.nuimages.yaml \
    --workers 8
cp -r ./experiments $saving_path
