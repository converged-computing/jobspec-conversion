#!/bin/bash
#FLUX: --job-name=longformer_5
#FLUX: -c=5
#FLUX: --queue=2080ti-long
#FLUX: -t=601200
#FLUX: --priority=16

export PYTHONPATH='/home/tianyiyang/git/CE2ERE/'

<<<<<<< HEAD
echo "SLURM_JOBID="$SLURM_JOBID
echo "SLURM_JOB_NODELIST"=$SLURM_JOB_NODELIST
echo "SLURM_NNODES"=$SLURM_NNODES
echo "SLURMTMPDIR="$SLURMTMPDIR
echo "working directory = "$SLURM_SUBMIT_DIR
source /home/tianyiyang/miniconda3/bin/activate
conda activate event-relation-extraction
export PYTHONPATH="/home/tianyiyang/git/CE2ERE/"
python src/__main__.py --data_dir=data --model bilstm --data_dir data --data_type matres --downsample 0.02 --epochs 50 --lambda_anno 1 --lambda_trans 0 --learning_rate 1e-05 --log_batch_size 6 --lstm_hidden_size 256 --lstm_input_size 768 --mlp_size 512 --roberta_hidden_size 768 --num_layers 1
echo "DONE"
