#!/bin/bash
#SBATCH --job-name=llmcompr
#SBATCH --output=zh_logs/eval_lm.txt
#SBATCH --mail-user=V.Moskvoretskii@skoltech.ru
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=2
#SBATCH --mem=16G
#SBATCH --time=00:04:00

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
