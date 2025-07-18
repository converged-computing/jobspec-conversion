#!/bin/bash
#FLUX: --job-name=tart-sundae-3568
#FLUX: --urgency=16

CONDA_BASE=$(conda info --base)
source $CONDA_BASE/etc/profile.d/conda.sh
conda activate eleet
nvidia-smi
python -c "import torch; print(torch.cuda.device_count())"
python scripts/pretrain.py \
    --log-level debug \
    --model-name-or-path models/base-models/tabert_base_k3/model.bin \
    --num-train-epochs 6 \
    --per-device-train-batch-size 6 \
    --train-batch-size 256 \
    --eval-steps 10_000 \
    --logging-steps 1000 \
    --dataloader-num-workers 55 \
    --dataset /mnt/labstore/murban/preprocessed_data_ready/preprocessed_trex-wikidata_v9*/data.h5 \
    # --resume models/checkpoint/pretraining/8af8c21_fixed-folder-structure-of-logging/2022-03-31_10-00-35_0_a1c122ca/
