#!/bin/bash
#SBATCH --output=/home/mila/m/marawan.gamal/projects/tensor-net/outputs/slurm-%j.out
#SBATCH --error=/home/mila/m/marawan.gamal/projects/tensor-net/outputs/slurm-error-%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=10G
#SBATCH --time=08:00:00
#SBATCH --exclude=cn-g[005-012,017-026]

module load python/3.8
source /home/mila/m/marawan.gamal/scratch/.venv/rosa/bin/activate
python train_mlm.py dataset.cache=$SLURM_TMPDIR/huggingface seed=42 +profile=marawan +task=cola train.batch_size=16 fnmodel.name=rosa fnmodel.params.rank=2 fnmodel.params.factorize_method=random_proj train.lr=2e-3
python train_mlm.py dataset.cache=$SLURM_TMPDIR/huggingface seed=42 +profile=marawan +task=cola train.batch_size=16 fnmodel.name=rosa fnmodel.params.rank=2 fnmodel.params.factorize_method=random_proj train.lr=2e-4
python train_mlm.py dataset.cache=$SLURM_TMPDIR/huggingface seed=42 +profile=marawan +task=cola train.batch_size=16 fnmodel.name=rosa fnmodel.params.rank=2 fnmodel.params.factorize_method=random_proj train.lr=2e-5
python train_mlm.py dataset.cache=$SLURM_TMPDIR/huggingface seed=42 +profile=marawan +task=cola train.batch_size=16 fnmodel.name=rosa fnmodel.params.rank=2 fnmodel.params.factorize_method=random_proj_orthogonal train.lr=2e-3
python train_mlm.py dataset.cache=$SLURM_TMPDIR/huggingface seed=42 +profile=marawan +task=cola train.batch_size=16 fnmodel.name=rosa fnmodel.params.rank=2 fnmodel.params.factorize_method=random_proj_orthogonal train.lr=2e-4
python train_mlm.py dataset.cache=$SLURM_TMPDIR/huggingface seed=42 +profile=marawan +task=cola train.batch_size=16 fnmodel.name=rosa fnmodel.params.rank=2 fnmodel.params.factorize_method=random_proj_orthogonal train.lr=2e-5
