#!/bin/bash
#SBATCH --job-name=neau0001_pytorch
#SBATCH --output=/home/neau0001/%x-%j.out.txt
#SBATCH --error=/home/neau0001/%x-%j.err.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --gres=gpu:1
#SBATCH --mem=64G
#SBATCH --time=2-00:00:00

export RES_DIR='sg2im_torch1.13/checkpoints/'
export OUT_DIR='/scratch/user/neau0001/sg2im_torch1.13/'

module load Miniconda3/4.9.2 NVHPC/22.7-CUDA-11.7.0
cd $BGFS
conda init --all
source /home/neau0001/.bashrc
conda activate /home/neau0001/.conda/envs/py39
cp -r /home/neau0001/sg2im_torch1.13 .
export RES_DIR="sg2im_torch1.13/checkpoints/"
echo "Saving to: "$RES_DIR
mkdir -p $RES_DIR
cd sg2im_torch1.13
python scripts/train.py --dataset vg --vg_image_dir /scratch/user/neau0001/VG_dataset/VG_100K --batch_size 64 --print_every 10000 --checkpoint_every 20000 --include_relationships 1 --image_size 128,128 --output_dir ./checkpoints --num_iterations 500000 --eval_mode_after 50000
export OUT_DIR="/scratch/user/neau0001/sg2im_torch1.13/"
mkdir -p $OUT_DIR
cp -r $RES_DIR $OUT_DIR
