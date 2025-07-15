#!/bin/bash
#FLUX: --job-name=expressive-parrot-5705
#FLUX: -t=172800
#FLUX: --priority=16

source ../../../../pytorch-1.11/bin/activate
module load gcc/8.2.0 python_gpu/3.10.4
rsync -aP /cluster/work/cvl/tiazhou/data/medical/FL/ProstateMRI.zip ${TMPDIR}/
unzip -q ${TMPDIR}/ProstateMRI.zip -d ${TMPDIR}/ProstateMRI
cd ../../../
trial=0
train_ratio=0.1
python main.py --config 'config.prostate_mri.fedavg' \
               --server 'euler' \
               --trial $trial \
               --train_ratio $train_ratio \
               --run_name 'fedavg_ratio_'$train_ratio'_trial_'$trial \
               --run_notes 'trial '$trial': fedavg' \
               --exp_name 'fedavg'
