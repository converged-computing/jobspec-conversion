#!/bin/bash
#FLUX: --job-name=gassy-house-9535
#FLUX: -n=4
#FLUX: -t=172800
#FLUX: --urgency=16

source ../../../../pytorch-1.11/bin/activate
module load gcc/8.2.0 python_gpu/3.10.4
rsync -aP /cluster/work/cvl/tiazhou/data/medical/FL/ProstateMRI.zip ${TMPDIR}/
unzip -q ${TMPDIR}/ProstateMRI.zip -d ${TMPDIR}/ProstateMRI
cd ../../../
mkdir -p logs_pyfed
trial=0
train_ratio=0.1
python main.py --config 'config.prostate_mri.fedfa' \
               --server 'euler' \
               --trial $trial \
               --train_ratio $train_ratio \
               --run_name 'fedfa_ratio_'$train_ratio'_trial_'$trial \
               --run_notes 'trial '$trial'' \
               --exp_name 'fedfa'
