#!/bin/bash
#SBATCH --job-name=bmp_pd
#SBATCH --mail-user=clabuzze@iastate.edu
#SBATCH --mail-type=FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:2
#SBATCH --time=08:00:00
#SBATCH --partition=gpu
#SBATCH --constraint=ntasks-per-node=12

export SM_FRAMEWORK='tf.keras;'

module load python/3.7.7-dwjowwi
python3 -c 'import tensorflow as tf; sess = tf.compat.v1.Session(config=tf.compat.v1.ConfigProto(log_device_placement=True))'
module load ml-gpu
export SM_FRAMEWORK=tf.keras;
ml-gpu python3 ~/bmp_wrr/cnn/model_wrr_pd_pps.py
