#!/bin/bash
#FLUX: --job-name=mclap
#FLUX: -N=3
#FLUX: --exclusive
#FLUX: --queue=gamma
#FLUX: --urgency=16

export NCCL_PROTO='simple'
export FI_EFA_FORK_SAFE='1'
export FI_LOG_LEVEL='1'
export FI_EFA_USE_DEVICE_RDMA='1 # use for p4dn'
export NCCL_DEBUG='info'
export OMPI_MCA_mtl_base_verbose='1'
export FI_EFA_ENABLE_SHM_TRANSFER='0'
export FI_PROVIDER='efa'
export FI_EFA_TX_MIN_CREDITS='64'
export NCCL_TREE_THRESHOLD='0'
export WORLD_SIZE='8'

module load cuda/11.3.1
module load mpi
export NCCL_PROTO=simple
export FI_EFA_FORK_SAFE=1
export FI_LOG_LEVEL=1
export FI_EFA_USE_DEVICE_RDMA=1 # use for p4dn
export NCCL_DEBUG=info
export OMPI_MCA_mtl_base_verbose=1
export FI_EFA_ENABLE_SHM_TRANSFER=0
export FI_PROVIDER=efa
export FI_EFA_TX_MIN_CREDITS=64
export NCCL_TREE_THRESHOLD=0
export WORLD_SIZE=8
OMP_NUM_THREADS=20 torchrun --nnodes=1 --nproc_per_node 8 --master_addr=localhost --master_port=2120 -m training.main \
    --name "run_2" \
    --save-frequency 5 \
    --save-top-performance 3 \
    --save-most-recent \
    --dataset-type="csv" \
    --precision="fp32" \
    --batch-size=24 \
    --lr=1e-4 \
    --wd=0.0 \
    --epochs=45 \
    --workers=1 \
    --use-bn-sync \
    --amodel HTSAT-tiny \
    --tmodel t5 \
    --warmup 3200 \
    --report-to "wandb" \
    --wandb-notes "t5_BEATS" \
    --train-data ./tain.csv \
    --val-data ./val.csv \
    --top-k-checkpoint-select-dataset="Clotho-test" \
    --top-k-checkpoint-select-metric="mAP@10" \
    --openai-model-cache-dir ./laion_clap \
    --logs /fsx/clap_logs \
    --seed 3407 \
    --gather-with-grad \
    --optimizer "adam" \
    --data-filling "repeatpad" \
    --data-truncating "fusion" \
    --enable-fusion \
    --fusion-type "aff_2d" \
    --pretrained-audio 'pretrained_path'
