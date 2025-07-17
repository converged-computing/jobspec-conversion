#!/bin/bash
#FLUX: --job-name=hairy-lettuce-9859
#FLUX: --queue=dcs-gpu
#FLUX: -t=288000
#FLUX: --urgency=16

export CXX='g++'

nvidia-smi
module load Anaconda3/2019.07
module load CUDA/10.2.89-GCC-8.3.0 # includes GCC 8.3 CUDA 10.2
source activate ML
export CXX=g++
mkdir $TMPDIR/data
cp -R /fastdata/acp21rjf/TEDLIUM1 $TMPDIR/data/
cp -R /fastdata/acp21rjf/sbnc $TMPDIR/data/
cp -R /home/acp21rjf/Legasee-Oral-History/ASR_systems/wav2vec2/train/data/FRED-S $TMPDIR/data/
cp -R /home/acp21rjf/Legasee-Oral-History/ASR_systems/wav2vec2/train/data/openslr $TMPDIR/data/
cp -R /home/acp21rjf/Legasee-Oral-History/ASR_systems/wav2vec2/train/data/hubert_train.csv $TMPDIR/data/
cp /home/acp21rjf/Legasee-Oral-History/ASR_systems/wav2vec2/train/hubert_train/adafactor.py $TMPDIR
cp /home/acp21rjf/Legasee-Oral-History/ASR_systems/wav2vec2/train/hubert_train/audio_dataset.py $TMPDIR
cp /home/acp21rjf/Legasee-Oral-History/ASR_systems/wav2vec2/train/hubert_train/main.py $TMPDIR
cp /home/acp21rjf/Legasee-Oral-History/ASR_systems/wav2vec2/train/hubert_train/models.py $TMPDIR
cp /home/acp21rjf/Legasee-Oral-History/ASR_systems/wav2vec2/train/hubert_train/model_utils.py $TMPDIR
cd $TMPDIR
torchrun --nnodes=1 --nproc_per_node=4 --standalone main.py
