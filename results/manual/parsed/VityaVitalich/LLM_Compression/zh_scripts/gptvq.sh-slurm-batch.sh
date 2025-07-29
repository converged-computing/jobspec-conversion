#!/bin/bash
#FLUX: --job-name=llmcompr
#FLUX: -c=8
#FLUX: --queue=ais-gpu
#FLUX: -t=300
#FLUX: --urgency=16

srun singularity exec --bind /trinity/home/v.moskvoretskii/:/home -f --nv /trinity/home/v.moskvoretskii/images/gptvq.sif bash -c '
    cd /home;
    export HF_TOKEN=hfxxxxxxxxxxxxxxxxxxxxxxxxxx;
    export SAVING_DIR=/home/cache/;
    export HF_HOME=/home/cache/;
    export TRANSFORMERS_CACHE=/home/cache/;
    export WANDB_API_KEY=xxxxxxxxxxxxxxxxxxxxxxxx;
    export CUDA_LAUNCH_BLOCKING=1;
    cd /home/LLM_Compression/gptvq;
    nvidia-smi;
    pip list;
    python llama.py meta-llama/Llama-2-7b-hf wikitext2 --columns-per-group 128 --use-vq --kmeans-iters 100 --kmeans-init-method mahalanobis --hessian-weighted-lookups --include-m-step --wbits 2 --vq-dim 2 --groupsize 2048 --codebook-bitwidth 8 --quantize-per-codebook  --output-dir /home/cache/gptvq_llama7b/
'
