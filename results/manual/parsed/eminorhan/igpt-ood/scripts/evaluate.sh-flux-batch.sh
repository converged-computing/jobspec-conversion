#!/bin/bash
#FLUX: --job-name=evaluate
#FLUX: -c=4
#FLUX: -t=172800
#FLUX: --priority=16

module purge
module load cuda/11.1.74
python -u /scratch/eo41/image-gpt/evaluate.py --model_size 'l' --prly 25 --batch_size 1201 --eval_data 'inst'
echo "Done"
