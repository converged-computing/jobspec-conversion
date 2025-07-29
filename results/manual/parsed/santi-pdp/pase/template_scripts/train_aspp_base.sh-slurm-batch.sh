#!/bin/bash
#SBATCH --job-name=aspp
#SBATCH --output=log/aspp_32000
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
        --save_path /export/team-mic/zhong/test/aspp_res_deep  \
        --net_cfg cfg/workers_aspp.cfg \
        --fe_cfg cfg/PASE_aspp.cfg \
        --do_eval --data_cfg /export/corpora/LibriSpeech_50h/librispeech_data_50h.cfg --min_lr 0.0005 --fe_lr 0.001 \
        --data_root /export/corpora/LibriSpeech_50h/wav_sel \
        --stats data/librispeech_50h_stats.pkl \
        --log_freq 100 \
	    --backprop_mode base \
	    --tensorboard True \
        --chunk_size 32000
