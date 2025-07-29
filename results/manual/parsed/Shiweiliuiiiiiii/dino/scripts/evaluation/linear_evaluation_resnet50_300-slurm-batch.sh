#!/bin/bash
#SBATCH --job-name=linear_RN50_300
#SBATCH --output=linear_RN50_300.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=18
#SBATCH --gres=1
#SBATCH --time=1-23:59:59
#SBATCH --partition=gpu
#SBATCH --constraint=ntasks-per-node=1

source /home/sliu/miniconda3/etc/profile.d/conda.sh
source activate slak
python -m torch.distributed.launch --nproc_per_node=1 --master_port=22345  eval_linear.py --data_path /projects/2/managed_datasets/imagenet/ \
--arch resnet50 --pretrained_weights /home/sliu/project_space/dino/resnet50_300/dino_resnet50_pretrain.pth \
--output_dir /projects/0/prjste21060/projects/dino/resnet50_300/linear/ --checkpoint_key teacher
source deactivate
