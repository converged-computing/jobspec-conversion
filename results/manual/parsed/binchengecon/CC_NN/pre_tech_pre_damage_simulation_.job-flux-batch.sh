#!/bin/bash
#FLUX: --job-name=modification
#FLUX: --queue=gpu
#FLUX: -t=129600
#FLUX: --priority=16

module load python/anaconda-2021.05
echo 
echo Program starts Mon Dec 4 21:12:37 CST 2023
start_time=1701745957
python pre_tech_post_damage.py /scratch/midway3/bincheng/pre_tech_pre_damage_models_12042023_tensorboard_version_0/pre_tech_post_damage -3.0 -1.5 32 10000 0.1 0.2  None 1000 10e-5,10e-5,10e-5,10e-5 swish,tanh,tanh,softplus None,custom,custom,softplus 4 32 None 0.025 True
python post_tech_pre_damage.py /scratch/midway3/bincheng/pre_tech_pre_damage_models_12042023_tensorboard_version_0/post_tech_pre_damage /scratch/midway3/bincheng/pre_tech_pre_damage_models_12042023_tensorboard_version_0/pre_tech_post_damage -3.0 -1.5 32 10000  0.1 0.2   None 1000 10e-5,10e-5,10e-5,10e-5 swish,tanh,tanh,softplus None,custom,custom,softplus 4 32 None 0.025 True
python pre_tech_pre_damage.py /scratch/midway3/bincheng/pre_tech_pre_damage_models_12042023_tensorboard_version_0 /scratch/midway3/bincheng/pre_tech_pre_damage_models_12042023_tensorboard_version_0/post_tech_pre_damage /scratch/midway3/bincheng/pre_tech_pre_damage_models_12042023_tensorboard_version_0/pre_tech_post_damage -10 -3.0 -1.5 32 10000  0.1 0.2   None 1000 10e-5,10e-5,10e-5,10e-5 swish,tanh,tanh,softplus None,custom,custom,softplus 4 32 None 0.025 True
