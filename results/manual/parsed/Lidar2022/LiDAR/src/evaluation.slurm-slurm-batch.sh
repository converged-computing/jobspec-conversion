#!/bin/bash
#SBATCH --job-name=gpu_job
#SBATCH --output=gpu_job-%j.out
#SBATCH --error=gpu_job-%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=32
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:A100.80gb:1
#SBATCH --mem-per-cpu=128G
#SBATCH --time=4-23:59:00
#SBATCH --partition=gpuq
#SBATCH --qos=gpu
#SBATCH --constraint=ntasks-per-node=32

set echo 
umask 0022 
nvidia-smi
module load gnu10
module load python
module load cudnn
module load nccl
for n in $(seq 5 5 3730)
do
        echo $n
        python evaluate.py --gpu_idx 0 --pretrained_path ../checkpoints/complexer_yolo/Model_complexer_yolo_epoch_${n}.pth --cfgfile ./config/cfg/complex_yolov3.cfg
done
