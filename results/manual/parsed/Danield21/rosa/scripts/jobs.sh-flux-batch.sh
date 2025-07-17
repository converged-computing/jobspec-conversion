#!/bin/bash
#FLUX: --job-name=reclusive-pot-0438
#FLUX: -t=28800
#FLUX: --urgency=16

module load python/3.8
source /home/mila/m/marawan.gamal/scratch/.venv/rosa/bin/activate
python train_mlm.py dataset.cache=$SLURM_TMPDIR/huggingface seed=42 +profile=marawan +task=cola train.batch_size=16 fnmodel.name=rosa fnmodel.params.rank=2 fnmodel.params.factorize_method=random_proj train.lr=2e-3
python train_mlm.py dataset.cache=$SLURM_TMPDIR/huggingface seed=42 +profile=marawan +task=cola train.batch_size=16 fnmodel.name=rosa fnmodel.params.rank=2 fnmodel.params.factorize_method=random_proj train.lr=2e-4
python train_mlm.py dataset.cache=$SLURM_TMPDIR/huggingface seed=42 +profile=marawan +task=cola train.batch_size=16 fnmodel.name=rosa fnmodel.params.rank=2 fnmodel.params.factorize_method=random_proj train.lr=2e-5
python train_mlm.py dataset.cache=$SLURM_TMPDIR/huggingface seed=42 +profile=marawan +task=cola train.batch_size=16 fnmodel.name=rosa fnmodel.params.rank=2 fnmodel.params.factorize_method=random_proj_orthogonal train.lr=2e-3
python train_mlm.py dataset.cache=$SLURM_TMPDIR/huggingface seed=42 +profile=marawan +task=cola train.batch_size=16 fnmodel.name=rosa fnmodel.params.rank=2 fnmodel.params.factorize_method=random_proj_orthogonal train.lr=2e-4
python train_mlm.py dataset.cache=$SLURM_TMPDIR/huggingface seed=42 +profile=marawan +task=cola train.batch_size=16 fnmodel.name=rosa fnmodel.params.rank=2 fnmodel.params.factorize_method=random_proj_orthogonal train.lr=2e-5
