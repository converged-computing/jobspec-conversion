#!/bin/bash
#FLUX: --job-name=evasive-rabbit-6807
#FLUX: -c=10
#FLUX: -t=3600
#FLUX: --urgency=16

echo Setting up environment
module load python/3.8
module load httpproxy
pwd
cd $SLURM_TMPDIR
virtualenv ./env
source ./env/bin/activate
pip install --no-index tensorflow
scp -r /home/s0mnaths/projects/def-skrishna/s0mnaths/datasets/Users/03253 .
echo untar done
ls 
cd $SLURM_TMPDIR/03253
ls
scp -r /home/s0mnaths/projects/def-skrishna/s0mnaths/model/create_tfrec_individuals.py .
echo copy done
echo begin tfrec conversion
python create_tfrec_individuals.py --filename 03253
echo DONE!
