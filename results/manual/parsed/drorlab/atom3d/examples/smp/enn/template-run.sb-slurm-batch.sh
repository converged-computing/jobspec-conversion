#!/bin/bash
#SBATCH --job-name=smp-TARGET-cormorant
#SBATCH --mail-user=mvoegele@stanford.edu
#SBATCH --mail-type=END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=24G
#SBATCH --time=1-00:00:00
#SBATCH --constraint=GPU_MEM:24GB

module load gcc/8.1.0
module load cuda/10.0
source /home/users/mvoegele/miniconda3/etc/profile.d/conda.sh
conda activate cormorant
echo $CUDA_HOME
LMDBDIR=/oak/stanford/groups/rondror/projects/atom3d/lmdb/SMP/splits/random/data/
python train.py --target TARGET --prefix smp-TARGET --load \
                --datadir $LMDBDIR --format lmdb --num-epoch 150
