#!/bin/bash
#FLUX: --job-name=milky-parsnip-9482
#FLUX: -c=6
#FLUX: -t=39600
#FLUX: --urgency=16

U_SIZE=$1
V_SIZE=$2
GRAPH_FAMILY=$3
PROBLEM=$4
FAMILY_PARAMETER=$5
TRAIN_SIZE=20000
VAL_SIZE=1000
EMBEDDING_SIZE=30
MAX_WEIGHT=100
WEIGHT_DIST=$6
MEAN=$7
VARIANCE=$8
a=3
DATASET="$PROBLEM"_"$GRAPH_FAMILY"_"$U_SIZE"by"$V_SIZE"_"p=$FAMILY_PARAMETER"_"$WEIGHT_DIST"_"m=$MEAN"_"v=$VARIANCE"_"a=$a"
MODEL=$9
module load python/3.7
module load scipy-stack
virtualenv --no-download $SLURM_TMPDIR/env
source $SLURM_TMPDIR/env/bin/activate
pip install --no-index --upgrade pip
pip install --no-index -r requirements.txt
tar xf ~/projects/def-khalile2/alomrani/$DATASET.tar -C $SLURM_TMPDIR/
mkdir $SLURM_TMPDIR/logs_$DATASET
python run.py --problem $PROBLEM --no_tensorboard --sweep_id ${11} --tune_wandb --num_per_agent ${12} --batch_size ${13} --eval_batch_size ${13} --embedding_dim $EMBEDDING_SIZE --n_heads 1 --u_size $U_SIZE --v_size $V_SIZE --n_epochs 300 --train_dataset $SLURM_TMPDIR/$DATASET/train --val_dataset $SLURM_TMPDIR/$DATASET/val --tune --dataset_size $TRAIN_SIZE --val_size $VAL_SIZE --checkpoint_epochs 0 --baseline exponential --lr_model 0.0001 --lr_decay 0.99 --output_dir $SLURM_TMPDIR/outputs_$DATASET --log_dir $SLURM_TMPDIR/logs_$DATASET --n_encode_layers ${10} --encoder mpnn --model $MODEL --max_grad_norm 1.0 --graph_family_parameter $FAMILY_PARAMETER --graph_family $GRAPH_FAMILY
