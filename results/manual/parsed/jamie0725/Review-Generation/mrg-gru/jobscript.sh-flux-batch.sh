#!/bin/bash
#FLUX: --job-name=quirky-hope-3042
#FLUX: -c=3
#FLUX: --queue=gpu_shared_course
#FLUX: -t=36000
#FLUX: --urgency=16

module purge
module load 2019
module load Python/3.6.6-foss-2018b
module load cuDNN/7.6.3-CUDA-10.0.130  
module load NCCL/2.4.7-CUDA-10.0.130
cp -r $HOME/mrg-gru $TMPDIR
cd $TMPDIR/mrg-gru
virtualenv env -p `which python3`
source env/bin/activate
pip install -r requirements.txt
python train.py
cp log.txt $HOME/mrg-gru
mkdir -p $HOME/mrg-gru/results
cp -r tmp/* $HOME/mrg-gru/results
