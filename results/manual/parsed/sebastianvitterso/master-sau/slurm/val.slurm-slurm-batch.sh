#!/bin/bash
#SBATCH --job-name=YOLOv5 Validation for sheep recognition
#SBATCH --account=ie-idi
#SBATCH --output=val.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=12000
#SBATCH --time=6-23:00:00
#SBATCH --partition=GPUQ
#SBATCH --constraint=A100|V100,ntasks-per-node=1

WORKDIR=${SLURM_SUBMIT_DIR}
cd ${WORKDIR} # /cluser/work/<username>/master-sau/slurm
uname -a
module purge
module load fosscuda/2020b
module load Python/3.8.6-GCCcore-10.2.0
cd ..
cd yolov5
pwd
FOLDER="rgb-small-no-msx"
python val.py --weights "runs/train/$FOLDER/weights/best.pt" --img 1280 --save-txt --save-conf --data sheep-cropped-no-msx.yaml --name $FOLDER
