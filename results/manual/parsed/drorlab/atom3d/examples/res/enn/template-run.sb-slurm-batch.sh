#!/bin/bash
#SBATCH --job-name=res-cormorant
#SBATCH --mail-user=mvoegele@stanford.edu
#SBATCH --mail-type=END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=20G
#SBATCH --time=1-00:00:00
#SBATCH --partition=rondror
#SBATCH --constraint=GPU_MEM:24GB

module load gcc/8.1.0
module load cuda/10.0
source /home/users/mvoegele/miniconda3/etc/profile.d/conda.sh
conda activate cormorant
echo $CUDA_HOME
LMDBDIR=/oak/stanford/groups/rondror/projects/atom3d/lmdb/RES/splits/split-by-cath-topology/data
python train.py --prefix res --load \
                --datadir $LMDBDIR --format LMDB\
                --ddir-suffix "_split-by-cath-topology" \
                --maxnum MAXNUM \
		--samples SAMPLES \
		--batch-size 1 \
                --num-epoch 30
