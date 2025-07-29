#!/bin/bash
#SBATCH --output=%N-%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=6
#SBATCH --gres=gpu:0
#SBATCH --mem=32G
#SBATCH --time=00:02:59

source activate pytorch
python tools/embeddings_to_torch.py -emb_file ../embeddings/glovewiki.en.vec -output_file data/embedding.50k.en -dict_file data/tok_en_de_50k.vocab.pt
