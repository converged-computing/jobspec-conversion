#!/bin/bash
#FLUX: --job-name=bricky-cherry-4493
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
pip install --no-index tensorflow
echo begin untar
tar -xf  /home/s0mnaths/projects/def-skrishna/s0mnaths/datasets/gt_fin_gs.tar.gz -C .
echo untar done
ls 
cd $SLURM_TMPDIR/gt_fin_gs
ls
scp -r /home/s0mnaths/projects/def-skrishna/s0mnaths/model/create_tfrec.py .
echo copy done
pwd
ls
echo begin tfrec conversion
python create_tfrec.py
echo DONE!
