#!/bin/bash
#SBATCH --job-name=lba-id30-cutoff-CUTOFF-maxnumat-MAXNUM-cormorant
#SBATCH --mail-user=mvoegele@stanford.edu
#SBATCH --mail-type=END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=20G
#SBATCH --time=1-00:00:00
#SBATCH --partition=rondror
#SBATCH --constraint=GPU_MEM:12GB

module load gcc/8.1.0
module load cuda/10.0
source /home/users/mvoegele/miniconda3/etc/profile.d/conda.sh
conda activate cormorant
echo $CUDA_HOME
LMDBDIR=/oak/stanford/groups/rondror/projects/atom3d/lmdb/LBA/splits/split-by-sequence-identity-30/data
python train.py --target neglog_aff --prefix lba-id30_cutoff-CUTOFF_maxnumat-MAXNUM --load \
                --datadir $LMDBDIR --format lmdb \
		--cgprod-bounded \
                --radius CUTOFF \
                --maxnum MAXNUM \
                --batch-size 1 \
                --num-epoch 150 
