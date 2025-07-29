#!/bin/bash
#FLUX: --job-name=hb_lg
#FLUX: -c=16
#FLUX: --exclusive
#FLUX: -t=72000
#FLUX: --urgency=16

module load pytorch-gpu/py3/2.1.1
conda activate aa
cd /gpfswork/rech/nkp/uaj64gk/attention_alt/brq-att-alt-exp
python -m torch.distributed.run --nproc_per_node=8 --rdzv_backend c10d --rdzv-endpoint=localhost:0 train.py hparams/hyperbranchformer_lg.yaml --find_unused_parameters
