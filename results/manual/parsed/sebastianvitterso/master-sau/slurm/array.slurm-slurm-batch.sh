#!/bin/bash
#SBATCH --job-name=Variance metrics
#SBATCH --account=ie-idi
#SBATCH --output=variance-train-3-%2a.out
#SBATCH --mail-user=sebastvi@stud.ntnu.no,ingebrin@stud.ntnu.no
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=12000
#SBATCH --time=6-23:00:00
#SBATCH --constraint=A100,ntasks-per-node=1
#SBATCH --array=1-50%10

export ARRAY_RUN_NAME='variance_03_exp$(printf %02.0f $SLURM_ARRAY_TASK_ID)'

WORKDIR=${SLURM_SUBMIT_DIR}
cd ${WORKDIR} # /cluster/work/<username>/master-sau/slurm
uname -a
module purge
module load fosscuda/2020b
module load Python/3.8.6-GCCcore-10.2.0
cd ..
cd yolov5
pwd
wandb online
export ARRAY_RUN_NAME="variance_03_exp$(printf %02.0f $SLURM_ARRAY_TASK_ID)"
python train.py --img 1280 --batch 8 --epochs 2000 --data sheep-cropped-no-msx-test.yaml --weights '' --cfg yolov5l6.yaml --cache --device 0 --name "$ARRAY_RUN_NAME"
python val.py --weights "runs/train/$ARRAY_RUN_NAME/weights/best.pt" --img 1280 --save-txt --save-conf --data sheep-cropped-no-msx.yaml --name "$ARRAY_RUN_NAME"
