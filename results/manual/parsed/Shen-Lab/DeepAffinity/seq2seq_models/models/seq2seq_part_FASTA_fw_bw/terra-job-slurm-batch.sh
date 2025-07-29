#!/bin/bash
#SBATCH --job-name=seq2seq_FASTA_fw_bw
#SBATCH --account=122788945864
#SBATCH --output=my_output
#SBATCH --mail-user=mostafa_karimi@tamu.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=28
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem-per-cpu=30G
#SBATCH --time=1-00:00:00

module load Anaconda/3-5.0.0.1
source activate tensorflow-gpu-1.3.0
module load cuDNN/5.1-CUDA-8.0.44
python translate.py --data_dir ./data --train_dir ./check-point --en_vocab_size=100 --fr_vocab_size=100
source deactivate
