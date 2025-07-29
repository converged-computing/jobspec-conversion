#!/bin/bash
#SBATCH --job-name=YOLOv5 Training for sheep recognition
#SBATCH --account=ie-idi
#SBATCH --output=job.out
#SBATCH --mail-user=sebastvi@stud.ntnu.no,ingebrin@stud.ntnu.no
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:V100:1
#SBATCH --mem=12000
#SBATCH --time=6-06:00:00
#SBATCH --partition=GPUQ
#SBATCH --constraint=ntasks-per-node=1

WORKDIR=${SLURM_SUBMIT_DIR}
cd ${WORKDIR} # /cluser/work/<username>/master-sau/slurm
uname -a
pip freeze --user | xargs pip uninstall -y
module purge
module load fosscuda/2020b
module load Python/3.8.6-GCCcore-10.2.0
cd ..
cd yolov5
pwd
pip install -r requirements.txt --no-cache-dir
python train.py --img 1280 --batch 6 --epochs 300 --data sheep-partitioned.yaml --weights '' --cfg yolov5l6.yaml --cache --device 0
