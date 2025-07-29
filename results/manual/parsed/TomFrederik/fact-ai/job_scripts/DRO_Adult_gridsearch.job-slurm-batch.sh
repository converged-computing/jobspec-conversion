#!/bin/bash
#FLUX: --job-name=DRO_adult_gridsearch
#FLUX: -c=6
#FLUX: --queue=gpu_shared_course
#FLUX: -t=37800
#FLUX: --urgency=16

module purge
module load 2019
module load Python/3.7.5-foss-2019b
module load CUDA/10.1.243
module load cuDNN/7.6.5.32-CUDA-10.1.243
module load NCCL/2.5.6-CUDA-10.1.243
module load Anaconda3/2018.12
cd $HOME/fact-ai/
source activate fact-ai-lisa
srun python -u main.py --model DRO --dataset Adult --disable_warnings --num_cpus 2 --num_workers 2 --tf_mode --train_steps 100000
