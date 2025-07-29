#!/bin/bash
#SBATCH --job-name=ESM
#SBATCH --output=ESM.%J.out
#SBATCH --error=ESM.%J.err
#SBATCH --mail-user=daulet.toibazar@kaust.edu.sa
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:1
#SBATCH --mem=20GB
#SBATCH --time=02:00:00
#SBATCH --constraint=v100

echo $OMP_NUM_THREADS
source activate base
module load cuda/11.7.1
cd /home/toibazd/Data/BERT/
python  ESM/extract.py esm2_t36_3B_UR50D ESM/few_proteins.fasta ESM/some_proteins_emb_esm2 --repr_layers 36 --include mean
