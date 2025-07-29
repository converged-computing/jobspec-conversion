#!/bin/bash
#SBATCH --job-name=ISIC2016_1_ResNet50V2_150h_150w
#SBATCH --output=/home/sanghyuk.kim001/MELANOMA/melanoma-detection-CNN/SLURMS/LOGS/ResNet50V2/%x_%A_%a.out
#SBATCH --error=/home/sanghyuk.kim001/MELANOMA/melanoma-detection-CNN/SLURMS/LOGS/ResNet50V2/%x_%A_%a.err
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
python train.py --DB ISIC2016 --IMG_SIZE 150 150 --CLASSIFIER ResNet50V2 --JOB_INDEX $SLURM_ARRAY_TASK_ID
echo "Job ended!"
exit 0;
