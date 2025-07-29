#!/bin/bash
#FLUX: --job-name=brqb
#FLUX: -c=16
#FLUX: --exclusive
#FLUX: -t=72000
#FLUX: --urgency=16

module load pytorch-gpu/py3/2.0.1
conda activate bestrqenv
cd /gpfswork/rech/nkp/uaj64gk/bestrqexp/bestrq
python -m torch.distributed.run --nproc_per_node=8 --rdzv_backend c10d --rdzv-endpoint=localhost:0 wav2vec2/train_sb_wav2vec2.py wav2vec2/hparams/wav2vec2_base.yaml --find_unused_parameters --bfloat16_mix_prec
