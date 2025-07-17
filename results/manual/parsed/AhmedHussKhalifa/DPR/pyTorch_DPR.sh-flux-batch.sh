#!/bin/bash
#FLUX: --job-name=moolicious-motorcycle-0684
#FLUX: -t=1200
#FLUX: --urgency=16

export LD_LIBRARY_PATH='$CUDA_HOME/lib64:$LD_LIBRARY_PATH'

module load python/3.6.3
virtualenv --no-download $SLURM_TMPDIR/torch_DPR
source $SLURM_TMPDIR/torch_DPR/bin/activate
pip install torch --no-index
pip install --no-index torch torchvision torchtext torchaudio
pip install --no-index transformers
pip install spacy[cuda] --no-index
module load nixpkgs/16.09  gcc/7.3.0  cuda/10.1
export LD_LIBRARY_PATH=$CUDA_HOME/lib64:$LD_LIBRARY_PATH
module load python/3.6.3
module load faiss/1.6.2
deactivate
source $SLURM_TMPDIR/torch_DPR/bin/activate
python --version
python dense_retriever.py \
	--model_file "/home/ahamsala/projects/def-ehyangit/ahamsala/DPR/output/dpr_biencoder.0.919" \
	--ctx_file "/home/ahamsala/projects/def-ehyangit/ahamsala/DPR/data/wikipedia_split/psgs_w100_subset.tsv" \
	--qa_file "data/retriever/nq-test.qa.csv" \
	--encoded_ctx_file "data/inference_0.pkl" \
	--out_file "data/result" \
	--n-docs 10 \
	--validation_workers 16 \
	--batch_size 32
