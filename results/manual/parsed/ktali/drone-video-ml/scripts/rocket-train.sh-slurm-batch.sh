#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:tesla:1
#SBATCH --mem=25000
#SBATCH --time=02:00:00
#SBATCH --constraint=ntasks-per-node=6

module load cuda/10.2.89-2fkd
source ../torchenv/bin/activate
python train.py --data data/person-coco.data --cfg cfg/yolov3-tiny-1cls.cfg --weights=weights/last.pt --single-cls --batch-size 42 --epochs 20
