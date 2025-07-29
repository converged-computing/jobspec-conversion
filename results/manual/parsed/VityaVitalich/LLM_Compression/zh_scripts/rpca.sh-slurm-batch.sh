#!/bin/bash
#FLUX: --job-name=llmcompr
#FLUX: -c=8
#FLUX: --queue=ais-gpu
#FLUX: -t=86400
#FLUX: --urgency=16

srun singularity exec --bind /trinity/home/v.moskvoretskii/:/home -f --nv /trinity/home/v.moskvoretskii/images/new_clipped_sm.sif bash -c '
    ls;
    cd /home;
    ls;
    export HF_HOME=/home/cache/;
    export HF_TOKEN=hf_xxxxxxxxxxxxxxxxxxxxxxxx;
    export SAVING_DIR=/home/cache/;
    export WANDB_API_KEY=xxxxxxxxxxxxxxxxxxx;
    cd /home/LLM_Compression;
    ls;
    nvidia-smi;
    pip list;
    CUDA_LAUNCH_BLOCKING=1;
    sh run_rpca.sh;
'
