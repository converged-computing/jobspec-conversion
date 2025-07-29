#!/bin/bash
#SBATCH --job-name=peg_real
#SBATCH --account=um_dke
#SBATCH --output=pegasus_log/pegasus_real_%A.log
#SBATCH --mail-user=my_email@email.com
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:pascal:1
#SBATCH --mem=12000
#SBATCH --time=1-00:00:00

export PATH='$HOME/.local/bin:$PATH'

module switch intel gcc/9
module load python/3.8.7
module load cuda/110
module load cudnn/8.0.5
module load cmake
module load LIBRARIES
module load intelmkl/2020
export PATH=$HOME/.local/bin:$PATH
cd $HOME/Documents/BSc-Thesis-AudioSumm/Models
DATA=$HOME/Documents/BSc-Thesis-AudioSumm/BuildDataset
nvidia-smi
python3 train_pegasus.py \
    -e 30 \
    -b 4 \
    -tb 4 \
    -l $WORK/pegasus_logs \
    -o $HPCWORK/pegasus_real_2 \
    --train-x $DATA/train_transcript_documents.pkl \
    --train-y $DATA/train_transcript_targets.pkl \
    --test-x $DATA/test_transcript_documents.pkl \
    --test-y $DATA/test_transcript_targets.pkl \
    -d cuda \
    --dropout 0.1 \
    -ml 256 \
