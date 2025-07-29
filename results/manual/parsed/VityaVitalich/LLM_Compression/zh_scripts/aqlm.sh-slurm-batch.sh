#!/bin/bash
#SBATCH --job-name=llmcompr
#SBATCH --output=zh_logs/aqlm.txt
#SBATCH --mail-user=V.Moskvoretskii@skoltech.ru
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=4
#SBATCH --mem=100G
#SBATCH --time=2-00:00:00

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
