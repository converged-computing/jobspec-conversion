#!/bin/bash
#FLUX: --job-name=peachy-leader-5689
#FLUX: --priority=16

export GROUP='conroy_lab'
export MYSCRATCH='$SCRATCH/$GROUP/$USER'
export SPS_HOME='$SCRATCH/$GROUP/$USER/fsps'

module purge
module load gcc/9.2.0-fasrc01
module load Anaconda3/5.0.1-fasrc01
export GROUP=conroy_lab
export MYSCRATCH=$SCRATCH/$GROUP/$USER
export SPS_HOME=$SCRATCH/$GROUP/$USER/fsps
source activate prox
cd $MYSCRATCH/exspect/fitting
tags=(phot spec specphot)
snrp=(20 0 20)
snrs=(0 10 10)
tag=${tags[$SLURM_ARRAY_TASK_ID]}
snr_phot=${snrp[$SLURM_ARRAY_TASK_ID]}
snr_spec=${snrs[$SLURM_ARRAY_TASK_ID]}
model="--add_neb --add_duste"
fit="--dynesty --nested_method=rwalk"
data="--add_noise --continuum_optimize"
zred=0.1
logzsol=-0.3
dust2=0.3
mass=1e10
tau=4
tage=12
mock="--zred=${zred} --tau=$tau --tage=$tage --logzsol=$logzsol --mass=$mass --dust2=$dust2"
python specphot_demo.py $fit $model $mock --zred_disp=1e-3 \
                        $data --snr_spec=$snr_spec --snr_phot=$snr_phot \
                        --outfile=output/mock_parametric_$tag
