#!/bin/bash
#SBATCH --job-name=YOLOv5 Training for sheep recognition
#SBATCH --account=ie-idi
#SBATCH --output=train.out
#SBATCH --mail-user=sebastvi@stud.ntnu.no,ingebrin@stud.ntnu.no
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=12000
#SBATCH --time=6-23:00:00
#SBATCH --constraint=A100,ntasks-per-node=1

WORKDIR=${SLURM_SUBMIT_DIR}
cd ${WORKDIR} # /cluser/work/<username>/master-sau/slurm
uname -a
module purge
module load fosscuda/2020b
module load Python/3.8.6-GCCcore-10.2.0
cd ..
cd yolov5
pwd
wandb online
python train.py --img 1280 --batch 8 --epochs 1000 --data sheep-cropped-no-msx.yaml --weights yolov5l6.pt --cache --device 0
