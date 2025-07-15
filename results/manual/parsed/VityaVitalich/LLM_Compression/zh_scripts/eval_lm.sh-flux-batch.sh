#!/bin/bash
#FLUX: --job-name=llmcompr
#FLUX: --queue=ais-gpu
#FLUX: -t=240
#FLUX: --urgency=16

srun singularity exec --bind /trinity/home/v.moskvoretskii/:/home -f --nv /trinity/home/v.moskvoretskii/images/compression.sif bash -c '
    ls;
    cd /home;
    ls;
    export HF_TOKEN=hf_xxxxxxxxxxxxxxxxxxxx;
    export SAVING_DIR=/home/cache/;
    export HF_HOME=/home/cache/;
    export TRANSFORMERS_CACHE=/home/cache/;
    export WANDB_API_KEY=xxxxxxxxxxxxxxxxxxxxxxx;
    export CUDA_LAUNCH_BLOCKING=1;
    cd /home/LLM_Compression;
    ls;
    nvidia-smi;
    pip list;
    sh evaluate.sh;
'
