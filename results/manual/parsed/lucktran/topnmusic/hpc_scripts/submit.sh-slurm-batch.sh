#!/bin/bash
#SBATCH --job-name=ast_finetuned
#SBATCH --output=ast_finetuned.out
#SBATCH --error=ast_finetuned.err
#SBATCH --mail-user=dilgrenc@oregonstate.edu
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=10G
#SBATCH --time=02:00:00
#SBATCH --partition=dgxs
#SBATCH --constraint=v100

module load python/3.12
module load cuda/12.2
source /nfs/hpc/share/dilgrenc/topnmusic/.venv/bin/activate
for lr in 5e-5
do
	for bs in 16
	do
   		.venv/bin/python3 ./src/topnmusic/ast_finetuned_audioset_finetuned_gtzan.py $lr $bs
    done
done
