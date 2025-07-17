#!/bin/bash
#FLUX: --job-name=boopy-noodle-8716
#FLUX: -c=10
#FLUX: -t=10800
#FLUX: --urgency=16

export NCCL_DEBUG='INFO'
export PYTHONFAULTHANDLER='1'
export DATA_DIR='/ibex/ai/reference/CV/ILSVR/classification-localization/data/jpeg'
export NV_PORT='$(python -c 'import socket; s=socket.socket(); s.bind(("", 0)); print(s.getsockname()[1]); s.close()')'

module load dl
module load pytorch
export NCCL_DEBUG=INFO
export PYTHONFAULTHANDLER=1
export DATA_DIR=/ibex/ai/reference/CV/ILSVR/classification-localization/data/jpeg
export NV_PORT=$(python -c 'import socket; s=socket.socket(); s.bind(("", 0)); print(s.getsockname()[1]); s.close()')
node=$(hostname -s)
time -p srun python multi_gpu.py --epochs=2 \
                         --num-nodes=${SLURM_NNODES} \
                         --gpus-per-node=${SLURM_GPUS_PER_NODE} \
                         --num-workers=10  \
                         --precision=32
