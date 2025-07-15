#!/bin/bash
#FLUX: --job-name=randomfreezeencoder
#FLUX: -c=6
#FLUX: -t=43200
#FLUX: --priority=16

module load python/3.10
virtualenv --no-download $SLURM_TMPDIR/env
source $SLURM_TMPDIR/env/bin/activate
pip install --no-index --upgrade pip
pip install --no-index -r /home/codee/scratch/sourcecode/cem-dataset/evaluation/requirements.txt
pip install /home/codee/segmentation_models_pytorch-0.3.3-py3-none-any.whl
module load cuda/11.4
log_dir="/home/codee/scratch/sourcecode/cem-dataset/evaluation/finetunesave"
echo log_dir : `pwd`/$log_dir
mkdir -p `pwd`/$log_dir
srun python /home/codee/scratch/sourcecode/cem-dataset/evaluation/finetune.py > $log_dir/randominitfreezeencode1.14
echo "finetune finished"
