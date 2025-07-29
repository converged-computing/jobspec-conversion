#!/bin/bash
#SBATCH --job-name=gpt2-en
#SBATCH --output=/hits/basement/nlp/fatimamh/outputs/gpt2_en/err-out/out-%j
#SBATCH --error=/hits/basement/nlp/fatimamh/outputs/gpt2_en/err-out/err-%j
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:1
#SBATCH --time=14-00:00:00

module load CUDA/10.1.243-GCC-8.3.0
. /home/fatimamh/anaconda3/etc/profile.d/conda.sh
conda activate hugging_face
python /hits/basement/nlp/fatimamh/codes/gpt2_summarization/main.py 
