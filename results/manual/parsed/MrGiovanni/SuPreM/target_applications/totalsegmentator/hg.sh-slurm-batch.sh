#!/bin/bash
#SBATCH --job-name=suprem
#SBATCH --output=%x_slurm_%j.out
#SBATCH --error=%xslurm_%j.err
#SBATCH --mail-user=zzhou82@asu.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=12
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=100G
#SBATCH --time=5-00:00:00

module load mamba/latest # only for Sol
source activate suprem
RANDOM_PORT=$((RANDOM % 64512 + 1024))
datapath=/scratch/zzhou82/data/Totalsegmentator_dataset/Totalsegmentator_dataset/ 
arch=swinunetr 
target_task=$1
num_target_class=$2
num_target_annotation=$3
suprem_path=pretrained_weights/supervised_suprem_swinunetr_2100.pth
checkpoint_path=out/efficiency.$arch.$target_task.number$num_target_annotation/best_model.pth
python -W ignore -m torch.distributed.launch --nproc_per_node=1 --master_port=$RANDOM_PORT train.py --dist --model_backbone $arch --log_name efficiency.$arch.$target_task.number$num_target_annotation --map_type $target_task --num_class $num_target_class --dataset_path $datapath --num_workers 12 --batch_size 8 --pretrain $suprem_path --percent $num_target_annotation
