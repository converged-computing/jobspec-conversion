#!/bin/bash
#FLUX: --job-name=egpd
#FLUX: -c=2
#FLUX: --queue=spgpu
#FLUX: -t=86400
#FLUX: --priority=16

export CUDA_HOME='~/miniconda3'

eval "$(conda shell.bash hook)"
conda init bash
conda activate eg3d
cd /home/zjf/repos/prolificdreamer
export CUDA_HOME=~/miniconda3
python main.py --text "A peach." --iters 25000 --lambda_entropy 10 --scale 7.5 --n_particles 1 --h 256  --w 256 --workspace exp-nerf-stage1/ --cfg=ffhq  --gen_pose_cond=True --data=lalla   --val_radius=3.0 --use_pretrained=/home/zjf/Downloads/ffhqrebalanced512-64.pkl
