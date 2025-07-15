#!/bin/bash
#FLUX: --job-name=nn_training
#FLUX: -c=4
#FLUX: --queue=gpu
#FLUX: -t=36000
#FLUX: --priority=16

module load gcc12-env/12.3.0
module load miniconda3/23.5.2
conda activate my_pytorch_env
cd $WORK/trading_bot
python -m src.model.training \
	--batch_size 16 \
	--hidden_layer_size 256 \
	--learning_rate 0.00005 \
	--epochs 5 \
	--dropout_rate 0.1 \
	--task "classification" 
