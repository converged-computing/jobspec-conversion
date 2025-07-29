#!/bin/bash
#SBATCH --job-name=wav2vec2_complete
#SBATCH --account=um_dke
#SBATCH --output=wav2vec2_log/train_wav2vec2_complete_%A.log
#SBATCH --mail-user=my_email@email.com
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:pascal:1
#SBATCH --mem=32000
#SBATCH --time=1-00:00:00

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
    -e 120000 \
    -b 16 \
    -tb 16 \
    -l $WORK/asr_logs \
    -o $HPCWORK/wav2vec2 \
    -d cuda \
    -t $TED \
    --ted-data $TEDDATA \
    --amara $AMARA \
    --amara-data $AMARADATA \
    --must-c $MUSTC \
    --dataset $DATASET \
    --test-output $WORK/wav2vec2 \
    -f 0 \
    --saved-train $HPCWORK/train_audio \
    --saved-test $HPCWORK/mustc_test_audio \
    --length 545320
   # -r
