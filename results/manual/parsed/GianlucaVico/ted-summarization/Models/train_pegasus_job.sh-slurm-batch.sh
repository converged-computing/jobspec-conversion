#!/bin/bash
#SBATCH --job-name=pegasus_hard
#SBATCH --account=um_dke
#SBATCH --output=pegasus_log/pegasus_filter_hard_%A.log
#SBATCH --mail-user=my_email@email.com
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:pascal:1
#SBATCH --mem=8000
#SBATCH --time=1-00:00:00

export PATH='$HOME/.local/bin:$PATH'

module switch intel gcc
module load python/3.8.7
export PATH=$HOME/.local/bin:$PATH
cd $HOME/Documents/BSc-Thesis-AudioSumm/Models
DATA=$HOME/Documents/BSc-Thesis-AudioSumm/BuildDataset
nvidia-smi
python3 train_pegasus.py \
    -e 5 \
    -b 4 \
    -tb 8 \
    -l $WORK/pegasus_logs \
    -o $HPCWORK/pegasus_filter_hard_final \
    --train-x $DATA/filter_train_documents_no_string.pkl \
    --train-y $DATA/filter_train_targets_no_string.pkl \
    --test-x $DATA/filter_test_documents_no_string.pkl \
    --test-y $DATA/filter_test_targets_no_string.pkl \
    -d cuda \
    --dropout 0.1 \
    -ml 256 \
    --eval \
