#!/bin/bash
#SBATCH --output=output.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=50g
#SBATCH --time=01:00:00
#SBATCH --partition=gpu

module load compilers/cuda/9.2
. ~/miniconda/etc/profile.d/conda.sh
conda activate style
startt=$(date +"%T")
python neural_style.py --content_img ducky_profile.jpg --style_imgs galaxy.jpg --max_size 1500 --max_iterations 1000 --device /gpu:0 --verbose
endt=$(date +"%T")
echo "Start to finish time: $startt -> $endt"
