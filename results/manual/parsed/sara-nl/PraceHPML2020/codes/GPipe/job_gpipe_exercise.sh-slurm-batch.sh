#!/bin/bash
#SBATCH --output=gpipe-exercise-%j.out
#SBATCH --error=gpipe-exercise-%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=6
#SBATCH --gres=gpu:gtx1080ti:2
#SBATCH --time=00:03:00

export PYTHONUNBUFFERED='1'

module purge
module load 2019
module load Python/3.6.6-foss-2019b
TEACHER_DIR=/home/ptc0000/
source ${TEACHER_DIR}/JHL_hooks/env
tar -C "$TMPDIR" -zxf ${TEACHER_DIR}/JHL_data/MNIST.tar.gz
export PYTHONUNBUFFERED=1
python ~/JHL_notebooks/GPipe/mnist_gpipe_exercise.py --arch resnet50 --datadir="$TMPDIR" --batchsize=512 --num_microbatches=6 --balance_by=time
