#!/bin/sh

# Run the interactive cQA simulations using BERT-cQA model

# FLUX: -N 1
# FLUX: -n 1
# FLUX: -c 24
# FLUX: --requires=mem=128G
# FLUX: --exclusive
# FLUX: -t 72:00:00
# FLUX: -J intcqa_bert_quick
# FLUX: -o /user/work/es1595/intercqabert.out.{id}
# FLUX: -e /user/work/es1595/intercqabert.err.{id}

# Note: Flux jobspec v1 does not have direct equivalents for mail notifications
# (--mail-user, --mail-type). This functionality, if required, would typically
# be handled by site-specific configurations or wrapper scripts around Flux.

#  load required modules
module load lang/python/anaconda/pytorch

# We might need to add the global paths to our code to the pythonpath. Also set the data directories globally.
cd /user/home/es1595/tacl2020-interactive-ranking
export OMP_NUM_THREADS=24 # Explicitly set, Flux might also set this based on -c

python -u stage1_coala.py GPPLHH 0 cqa_bert_imp_gpplhh_4 "[imp]" . 4 4 BERT