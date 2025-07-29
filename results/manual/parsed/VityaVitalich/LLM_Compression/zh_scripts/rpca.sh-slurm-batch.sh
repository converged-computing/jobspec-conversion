#!/bin/bash
#SBATCH --job-name=llmcompr
#SBATCH --output=zh_logs/rpca.txt
#SBATCH --mail-user=V.Moskvoretskii@skoltech.ru
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=1
#SBATCH --mem=100G
#SBATCH --time=1-00:00:00
#SBATCH --partition=ais-gpu

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
