#!/bin/bash
#FLUX: --job-name=llmcompr
#FLUX: --queue=ais-gpu
#FLUX: -t=172800
#FLUX: --priority=16

srun singularity exec --bind /trinity/home/v.moskvoretskii/:/home -f --nv /trinity/home/v.moskvoretskii/images/aqlm.sif bash -c '
    ls;
    cd /home;
    ls;
    export HF_HOME=/home/cache/;
    export HF_TOKEN=xxxxxxxxxxxxxx;
    export SAVING_DIR=/home/cache/;
    export WANDB_API_KEY=xxxxxxxxxx;
    cd /home/LLM_Compression/AQLM;
    ls;
    nvidia-smi;
    pip list;
    CUDA_LAUNCH_BLOCKING=1;
    sh quantize.sh;
'
