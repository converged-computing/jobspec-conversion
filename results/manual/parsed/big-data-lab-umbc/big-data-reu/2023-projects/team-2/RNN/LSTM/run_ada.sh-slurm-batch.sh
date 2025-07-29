#!/bin/bash
#SBATCH --job-name=4g_lstm_low_batch
#SBATCH --output=slurm.out
#SBATCH --error=slurm.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:4
#SBATCH --mem=48G
#SBATCH --time=3-23:00:00
#SBATCH --constraint=rtx_8000

if [ -f "model-final" ] || [ -d "model-final" ]
then
    scancel $SLURM_ARRAY_JOB_ID
else
    module load PyTorch/1.12.1-foss-2022a-CUDA-11.7.0
    module load Anaconda3/2020.07
    source /usr/ebuild/software/Anaconda3/2020.07/bin/activate
    conda activate /nfs/rs/cybertrn/reu2023/team2/research/ada_envs/torch-env
    # debugging flags
    export NCCL_DEBUG=INFO
    export PYTHONFAULTHANDLER=1
    srun python main.py resume_training
fi
