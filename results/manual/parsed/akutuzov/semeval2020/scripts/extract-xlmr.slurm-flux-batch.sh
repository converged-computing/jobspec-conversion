#!/bin/bash
#FLUX: --job-name=XLMR_extract
#FLUX: -c=6
#FLUX: --queue=accel
#FLUX: -t=108000
#FLUX: --urgency=16

module use -a /fp/projects01/ec30/software/easybuild/modules/all/
module purge   # Recommended for reproducibility
module load nlpl-datasets/1.17-foss-2019b-Python-3.7.4
module load nlpl-transformers/4.14.1-foss-2019b-Python-3.7.4
module load nlpl-gensim/3.8.3-foss-2019b-Python-3.7.4
language=${1}
bsz=32
context=256
mkdir -p embeddings/$language/
for corpus in corpus1 corpus2
    do
    echo "Processing ${corpus}..."
        python3 -m torch.distributed.launch --nproc_per_node=1 --nnodes=1 --node_rank=0  \
                ../code/xlmr/extract.py \
                --model_name_or_path finetuned_models/$language \
                --corpus_path finetuning_corpora/$language/token/${corpus}.txt.gz \
                --targets_path targets/$language/target_forms_udpipe.csv \
                --output_path embeddings/$language/${corpus}.npz \
                --context_window $context \
                --batch_size $bsz
    done
