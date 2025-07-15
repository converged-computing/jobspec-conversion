#!/bin/bash
#FLUX: --job-name=muffled-hope-5678
#FLUX: --priority=16

source ~/.local/bin/miniconda3/etc/profile.d/conda.sh
conda activate bbt
python bbt.py --seed 8 --task_name 'sst2'
python bbt.py --seed 8 --task_name 'qnli'
python bbt.py --seed 8 --task_name 'qqp'
python bbt.py --seed 8 --task_name 'snli'
python bbt.py --seed 8 --task_name 'dbpedia'
