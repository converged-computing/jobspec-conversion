#!/bin/bash
#SBATCH --job-name=brvit
#SBATCH --account=furongh
#SBATCH --output=brvit.out
#SBATCH --error=brvit.err
#SBATCH --mail-user=pding@umd.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --gres=gpu:4
#SBATCH --mem=64G
#SBATCH --time=1-12:00:00
#SBATCH --qos=high
#SBATCH --constraint=ntasks-per-node=1

nvidia-smi
module load cuda/11.3.1   
source ~/miniconda3/bin/activate
conda activate swin 
cd ~/Swin-Transformer
torchrun  --nproc_per_node 4  --master_port 29499  main.py --cfg configs/swin/vit_relpos_b_0304.yaml --data-path /fs/cml-datasets/ImageNet/ILSVRC2012 --output /cmlscratch/pding 
