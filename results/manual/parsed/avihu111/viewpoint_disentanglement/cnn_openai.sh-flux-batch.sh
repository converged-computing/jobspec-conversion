#!/bin/bash
#FLUX: --job-name=salted-itch-6349
#FLUX: -t=172800
#FLUX: --urgency=16

export PYTHONPATH='/cs/labs/daphna/avihu.dekel/DALLE-pytorch:/cs/labs/daphna/avihu.dekel/stylegan2'

dir=/cs/labs/daphna/avihu.dekel/DALLE-pytorch/
cd $dir
module spider cuda
module load cuda/11.1
source /cs/labs/daphna/avihu.dekel/stylegan2/style_venv/bin/activate
export PYTHONPATH=/cs/labs/daphna/avihu.dekel/DALLE-pytorch:/cs/labs/daphna/avihu.dekel/stylegan2
.
python train_lord_dalle.py --dalle_output_file_name ffhq_transformer --lr_decay --dataset ffhq_small --vae_type openai --batch_size 20 --learning_rate 0.001
