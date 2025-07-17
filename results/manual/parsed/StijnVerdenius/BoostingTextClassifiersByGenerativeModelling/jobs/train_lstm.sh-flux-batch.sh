#!/bin/bash
#FLUX: --job-name=train_lstm
#FLUX: -c=3
#FLUX: --queue=gpu_shared_course
#FLUX: -t=86400
#FLUX: --urgency=16

export LD_LIBRARY_PATH='/hpc/eb/Debian9/cuDNN/7.1-CUDA-8.0.44-GCCcore-5.4.0/lib64:$LD_LIBRARY_PATH'

module purge
module load eb
module load Python/3.6.3-foss-2017b
module load cuDNN/7.0.5-CUDA-9.0.176
module load NCCL/2.0.5-CUDA-9.0.176
export LD_LIBRARY_PATH=/hpc/eb/Debian9/cuDNN/7.1-CUDA-8.0.44-GCCcore-5.4.0/lib64:$LD_LIBRARY_PATH
srun python3 -u main.py --classifier LSTMClassifier --dataset_class LyricsDataset --loss CrossEntropyLoss --train-classifier
