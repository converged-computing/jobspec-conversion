#!/bin/bash
#FLUX: --job-name=bmp_te
#FLUX: --queue=gpu
#FLUX: -t=28800
#FLUX: --urgency=16

export SM_FRAMEWORK='tf.keras;'

module load python/3.7.7-dwjowwi
python3 -c 'import tensorflow as tf; sess = tf.compat.v1.Session(config=tf.compat.v1.ConfigProto(log_device_placement=True))'
module load ml-gpu
export SM_FRAMEWORK=tf.keras;
ml-gpu python3 ~/bmp_wrr/cnn/model_wrr_te_cldice.py
