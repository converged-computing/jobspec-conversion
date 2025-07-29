#!/bin/bash
#SBATCH --job-name=ISIC2017_1_ResNet50_640h_640w
#SBATCH --output=/home/sanghyuk.kim001/MELANOMA/melanoma-detection-CNN/SLURMS/LOGS/ResNet50/%x_%A_%a.out
#SBATCH --error=/home/sanghyuk.kim001/MELANOMA/melanoma-detection-CNN/SLURMS/LOGS/ResNet50/%x_%A_%a.err
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:A100:1
#SBATCH --mem-per-cpu=200gb
#SBATCH --time=1-00:00:00
#SBATCH --nodelist=chimera13

eval "$(conda shell.bash hook)"
conda activate clean_chimera_env
echo `date`
python --version
nvcc -V
echo "My SLURM_ARRAY_TASK_ID: " $SLURM_ARRAY_TASK_ID
cd /home/sanghyuk.kim001/MELANOMA/melanoma-detection-CNN/
python train.py --DB ISIC2017 --IMG_SIZE 640 640 --CLASSIFIER ResNet50 --JOB_INDEX $SLURM_ARRAY_TASK_ID
echo "Job ended!"
exit 0;
