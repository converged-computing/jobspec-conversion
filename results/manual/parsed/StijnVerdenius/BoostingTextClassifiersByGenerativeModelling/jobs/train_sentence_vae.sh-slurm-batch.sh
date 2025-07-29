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
for genre in 'Pop' 'Rock' 'Hip-Hop' 'Metal' 'Country'
do
	srun python3 -u main.py --generator SentenceVAE --dataset_class LyricsRawDataset --loss VAELoss --batch_size 16 --device cuda --eval_freq 100 --embedding_size 256 --hidden_dim 64 --genre $genre --run_name 'sentence-vae-genre-'$genre >> 'output/train-sentence-vae-genre-'$genre'-seed-42.out'
done
