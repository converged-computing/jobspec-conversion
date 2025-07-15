#!/bin/bash
#FLUX: --job-name=red-pot-0613
#FLUX: -c=6
#FLUX: -t=179
#FLUX: --urgency=16

source activate pytorch
python tools/embeddings_to_torch.py -emb_file ../embeddings/glovewiki.en.vec -output_file data/embedding.50k.en -dict_file data/tok_en_de_50k.vocab.pt
