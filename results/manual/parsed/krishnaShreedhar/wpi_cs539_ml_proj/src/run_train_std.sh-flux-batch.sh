#!/bin/bash
#FLUX: --job-name=mri_std
#FLUX: --queue=whitehill
#FLUX: -t=194400
#FLUX: --urgency=16

module load cuda11.1/toolkit/11.1.1
module load cudnn/8.1.1.33-11.2/3k5bbs63
source /home/sskodate/py37_venv/bin/activate
echo "Starting to run mri_std_nw"
python3 3d_model_training_std.py --model_to_train=3dcnn --epochs=50 --initial_lr=0.01 --decay_steps=100000 --decay_rate=0.96 --patience=50 --verbose=2 --w_width=192 --h_height=192 --d_depth=60 --classes=2 --mri_type=T1w --max_data=1000 --batch_size=2
python3 3d_model_training_std.py --model_to_train=resnet --epochs=50 --initial_lr=0.01 --decay_steps=100000 --decay_rate=0.96 --patience=50 --verbose=2 --w_width=192 --h_height=192 --d_depth=60 --classes=2 --mri_type=T1w --max_data=1000 --batch_size=2
python3 3d_model_training_std.py --model_to_train=3dcnn --epochs=50 --initial_lr=0.01 --decay_steps=100000 --decay_rate=0.96 --patience=50 --verbose=2 --w_width=192 --h_height=192 --d_depth=60 --classes=2 --mri_type=T2w --max_data=1000 --batch_size=2
python3 3d_model_training_std.py --model_to_train=resnet --epochs=50 --initial_lr=0.01 --decay_steps=100000 --decay_rate=0.96 --patience=50 --verbose=2 --w_width=192 --h_height=192 --d_depth=60 --classes=2 --mri_type=T2w --max_data=1000 --batch_size=2
python3 3d_model_training_std.py --model_to_train=3dcnn --epochs=50 --initial_lr=0.01 --decay_steps=100000 --decay_rate=0.96 --patience=50 --verbose=2 --w_width=192 --h_height=192 --d_depth=60 --classes=2 --mri_type=T1wCE --max_data=1000 --batch_size=2
python3 3d_model_training_std.py --model_to_train=resnet --epochs=50 --initial_lr=0.01 --decay_steps=100000 --decay_rate=0.96 --patience=50 --verbose=2 --w_width=192 --h_height=192 --d_depth=60 --classes=2 --mri_type=T1wCE --max_data=1000 --batch_size=2
python3 3d_model_training_std.py --model_to_train=3dcnn --epochs=50 --initial_lr=0.01 --decay_steps=100000 --decay_rate=0.96 --patience=50 --verbose=2 --w_width=192 --h_height=192 --d_depth=60 --classes=2 --mri_type=FLAIR --max_data=1000 --batch_size=2
python3 3d_model_training_std.py --model_to_train=resnet --epochs=50 --initial_lr=0.01 --decay_steps=100000 --decay_rate=0.96 --patience=50 --verbose=2 --w_width=192 --h_height=192 --d_depth=60 --classes=2 --mri_type=FLAIR --max_data=1000 --batch_size=2
