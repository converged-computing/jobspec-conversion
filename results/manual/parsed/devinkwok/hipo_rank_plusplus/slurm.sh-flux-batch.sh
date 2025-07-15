#!/bin/bash
#FLUX: --job-name=peachy-fudge-1398
#FLUX: -c=2
#FLUX: --queue=unkillable
#FLUX: -t=86400
#FLUX: --urgency=16

SRC_DIR=$HOME/proj/hiporank_plusplus
module load python/3.7
module load python/3.7/cuda/10.1/cudnn/8.0/pytorch/1.6.0
virtualenv $SLURM_TMPDIR/env/
source $SLURM_TMPDIR/env/bin/activate
pip install --upgrade pip
pip install -r $SRC_DIR/requirements.txt
pyrouge_set_rouge_path $SRC_DIR/ROUGE-1.5.5/
python $SRC_DIR/hpp_test.py
