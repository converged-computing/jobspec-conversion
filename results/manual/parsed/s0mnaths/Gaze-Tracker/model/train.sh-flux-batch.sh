#!/bin/bash
#FLUX: --job-name=nerdy-knife-7140
#FLUX: -c=10
#FLUX: -t=86400
#FLUX: --urgency=16

echo Setting up environment
module load python/3.8
module load httpproxy
pwd
cd $SLURM_TMPDIR
virtualenv ./env
source ./env/bin/activate
echo Installing TF!
pip install --no-index comet-ml tensorflow
pwd
scp -r /home/s0mnaths/projects/def-skrishna/s0mnaths/model/ .
echo copy done
ls
echo begin training
cd $SLURM_TMPDIR/model
python main2.py --epoch 50 --dataset_dir /home/s0mnaths/projects/def-skrishna/s0mnaths/datasets/google_split_tfrec/ --save_dir /home/s0mnaths/projects/def-skrishna/s0mnaths/checkpoints/new_mod/gs/newex50/ --version_description gsnewex50
echo end training
echo DONE
