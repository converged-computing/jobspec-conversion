#!/bin/bash
#SBATCH --job-name=mmdetect
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=dcu:4
#SBATCH --constraint=ntasks-per-node=4

export MIOPEN_DEBUG_DISABLE_FIND_DB='1'

module unload compiler/rocm/2.9
module rm compiler/rocm/2.9
module load apps/PyTorch/1.5.0a0/hpcx-2.4.1-gcc-7.3.1-rocm3.3
export MIOPEN_DEBUG_DISABLE_FIND_DB=1
python3 tools/train.py configs/faster_rcnn/faster_rcnn_r50_fpn_1x_coco.py --work-dir=./work1
