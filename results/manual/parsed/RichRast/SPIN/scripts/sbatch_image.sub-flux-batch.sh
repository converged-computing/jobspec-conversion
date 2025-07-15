#!/bin/bash
#FLUX: --job-name=boopy-taco-7432
#FLUX: --urgency=16

source /home/rr568/NPT/non-parametric-transformers/scripts/init_env.sh
echo 'Begin npt'
free -h 
python $USER_PATH/image_npt.py --model_checkpoint_key=resnet_npt --train_batch_size=480 --train_at_test_batch_size=400 --test_batch_size=80 --use_pretrained_resnet=False --npt_type=npt --train_label_masking_perc=0.5 --project Image_Data --exp_name Resnet_NPT --data_set 'cifar-10'
echo 'Submission finished'
