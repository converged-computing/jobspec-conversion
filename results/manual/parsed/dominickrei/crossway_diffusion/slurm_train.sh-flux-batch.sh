#!/bin/bash
#FLUX: --job-name=diffusion-policy-crossway_vit-t_backbone
#FLUX: -c=8
#FLUX: --queue=GPU
#FLUX: -t=259200
#FLUX: --urgency=16

module load anaconda3
module load cuda
module list
conda init bash
source ~/.bashrc
conda activate robo
echo Active env: $CONDA_DEFAULT_ENV
echo $(nvidia-smi)
echo config path is $config_path seed is $seed type is $type 
echo started running script
EGL_DEVICE_ID=0 python /users/dreilly1/Projects/robotics/crossway_diffusion/train.py --config-dir=config/$config_path/ --config-name=$type.yaml training.seed=$seed hydra.run.dir='outputs/vit-t-baselines/${now:%Y-%m-%d}/${now:%H-%M-%S}_${task_name}_${task.dataset_type}'
echo finished running script
echo config path is $config_path seed is $seed type is $type
