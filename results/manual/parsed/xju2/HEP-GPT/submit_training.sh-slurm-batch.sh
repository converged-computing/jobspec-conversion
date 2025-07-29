#!/bin/bash
#SBATCH --job-name=odd_v1
#SBATCH --account=m3443_g
#SBATCH --output=logs/%x-%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=32
#SBATCH --gpus-per-task=1
#SBATCH --time=1-00:00:00
#SBATCH --partition=regular
#SBATCH --constraint=gpu,ntasks-per-node=1
#SBATCH --licenses=scratch,cfs

export NCCL_DEBUG='INFO'
export PYTHONFAULTHANDLER='1'

mkdir -p logs
export NCCL_DEBUG=INFO
export PYTHONFAULTHANDLER=1
function train_v1() {
  srun python main.py experiment=odd \
        model.model.n_embd=1024 model.model.n_layer=24 \
        datamodule.block_size=22 datamodule.batch_size=1024 datamodule.num_workers=0 \
        trainer.max_epochs=100 +trainer.limit_val_batches=10
}
train_v1
