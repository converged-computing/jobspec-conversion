#!/bin/bash
#FLUX: --job-name=pusheena-pedo-2329
#FLUX: -t=86400
#FLUX: --urgency=16

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
