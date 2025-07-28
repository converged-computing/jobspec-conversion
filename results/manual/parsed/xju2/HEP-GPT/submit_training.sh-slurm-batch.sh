#!/bin/bash
#FLUX: --job-name=odd_v1
#FLUX: -c=32
#FLUX: --gpus-per-task=1
#FLUX: --queue=regular
#FLUX: -t=86400
#FLUX: --urgency=16

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
