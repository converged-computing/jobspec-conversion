#!/bin/bash
#SBATCH --job-name=ff
#SBATCH --account=nkp@v100
#SBATCH --output=log/ff_%j.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --gres=gpu:8
#SBATCH --time=20:00:00
#SBATCH --partition=gpu_p2
#SBATCH: --exclusive
#SBATCH --constraint=v100

module load pytorch-gpu/py3/2.1.1
conda activate aa
cd /gpfswork/rech/nkp/uaj64gk/attention_alt/brq-att-alt-exp
python -m torch.distributed.run --nproc_per_node=8 --rdzv_backend c10d --rdzv-endpoint=localhost:0 train.py hparams/fastformer.yaml --find_unused_parameters
