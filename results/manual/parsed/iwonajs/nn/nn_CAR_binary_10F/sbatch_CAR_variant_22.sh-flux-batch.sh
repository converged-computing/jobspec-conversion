#!/bin/bash
#FLUX: --job-name=boopy-bits-2013
#FLUX: -c=4
#FLUX: -t=10800
#FLUX: --urgency=16

cp *.json $SLURM_TMPDIR
cp *.py $SLURM_TMPDIR
cp *.sh $SLURM_TMPDIR
tar xf input.tar.gz -C $SLURM_TMPDIR
module load python/3.7.4
module load cuda cudnn
module load scipy-stack
virtualenv --no-download $SLURM_TMPDIR/env
source $SLURM_TMPDIR/env/bin/activate
pip install --no-index tensorflow_gpu
nvidia-smi
echo "*********************************************************************"
cd $SLURM_TMPDIR
ls -l
echo "^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^"
python ./run_terminal.py -n $SLURM_ARRAY_TASK_ID -u 10 -m 22 --chkpt True --flat 1
tar -cf ~/projects/def-miranska/iwonajs/nn_CAR_binary_10F/CAR_variant_22_$SLURM_ARRAY_TASK_ID.tar results
