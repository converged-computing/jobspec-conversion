#!/bin/bash
#SBATCH --job-name=dropout
#SBATCH --output=log/dropout_32000
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu
#SBATCH --mem=32GB
#SBATCH --time=5-00:00:00
#SBATCH --constraint=K80

module load cuda
module load anaconda
source activate humor
conda info -e
nvidia-smi
python -u train.py --batch_size 32 --epoch 150 --num_workers 8 \
        --save_path /scratch/jzhong9/model_ckpt/dropout_32000  \
        --net_cfg cfg/workers.cfg \
        --fe_cfg cfg/PASE_dense.cfg \
        --do_eval --data_cfg /scratch/jzhong9/data/LibriSpeech_50h/librispeech_data_50h.cfg --min_lr 0.0005 --fe_lr 0.001 \
        --data_root /scratch/jzhong9/data/LibriSpeech_50h/wav_sel \
        --stats /scratch/jzhong9/data/LibriSpeech_50h/librispeech_50h_stats.pkl \
        --log_freq 100 \
	    --backprop_mode dropout --dropout_rate 0.5 \
	    --tensorboard False \
        --chunk_size 32000
