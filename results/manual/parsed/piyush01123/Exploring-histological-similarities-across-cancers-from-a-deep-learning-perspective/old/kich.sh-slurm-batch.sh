#!/bin/bash
#SBATCH --account=delta_one
#SBATCH --nodes=1
#SBATCH --ntasks=20
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:2
#SBATCH --mem-per-cpu=1024
#SBATCH --time=1-00:00:00
#SBATCH --nodelist=gnode26

module load cuda/9.0
module load cudnn/7-cuda-9.0
source /home/delta_one/v3env/bin/activate
python /home/delta_one/project/histopathology/classifier.py \
                     --train_dir /ssd_scratch/cvit/medicalImaging/PATCHES_KICH/train/ \
                     --val_dir /ssd_scratch/cvit/medicalImaging/PATCHES_KICH/valid/ \
                     --num_epochs 20 \
                     --log_dir kich_logs/  \
                     --batch_size 32 \
                     --model_checkpoint /home/delta_one/project/histopathology/exports/kich_with_dropout_0.5/KICH_model_epoch_0.pth \
                     --save_prefix KICH > trg_log_kich.txt
sleep 5
