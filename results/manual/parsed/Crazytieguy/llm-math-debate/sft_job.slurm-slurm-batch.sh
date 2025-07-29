#!/bin/bash
#SBATCH --job-name=llm_math_debate_sft
#SBATCH --output=job_outputs/%x_%j.out
#SBATCH --error=job_outputs/%x_%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:rtx8000:4
#SBATCH --mem=96G
#SBATCH --time=06:00:00

singularity exec --nv --overlay $SCRATCH/llm-math-debate.ext3:ro /scratch/work/public/singularity/cuda11.8.86-cudnn8.7-devel-ubuntu22.04.2.sif /bin/bash -c "
source /ext3/env.sh
python -m llm_math_debate.training.sft
python -m llm_math_debate.training.sft_test
"
