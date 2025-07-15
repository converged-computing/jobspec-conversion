#!/bin/bash
#FLUX: --job-name="wav2vec2_complete"
#FLUX: -t=43200
#FLUX: --priority=16

export PATH='$HOME/.local/bin:$PATH'
export KENLM_ROOT='$HOME/kenlm'

module switch intel gcc/9
module load python/3.8.7
module load cuda/110
module load cudnn/8.0.5
module load cmake
module load LIBRARIES
module load intelmkl
export PATH=$HOME/.local/bin:$PATH
export KENLM_ROOT=$HOME/kenlm
cd $HOME/Documents/BSc-Thesis-AudioSumm/Models
DATA=$HOME/Documents/BSc-Thesis-AudioSumm/BuildDataset
MUSTC=$WORK/MUST-C/en-cs/data
TEDDATA=$WORK/TED/Data
TED=$HOME/Documents/BSc-Thesis-AudioSumm/BuildDataset/TED
AMARADATA=$WORK/AMARA
AMARA=$WORK/AMARA
DATASET=$HOME/Documents/BSc-Thesis-AudioSumm/BuildDataset/integrated_data.csv
echo ted
echo $TED
nvidia-smi
python3 train_wav2vec2.py \
    -l $WORK/asr_logs \
    -o .. \
    -d cuda \
    -t $TED \
    --ted-data $TEDDATA \
    --amara $AMARA \
    --amara-data $AMARADATA \
    --must-c $MUSTC \
    --dataset $DATASET \
    --test-output .. \
    --transcribe \
    -m $HPCWORK/wav2vec2_mustc/checkpoint-15000-best
