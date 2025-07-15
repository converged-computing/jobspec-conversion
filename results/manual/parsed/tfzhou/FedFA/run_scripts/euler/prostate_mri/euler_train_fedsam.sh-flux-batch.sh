#!/bin/bash
#FLUX: --job-name=buttery-hobbit-5084
#FLUX: -t=172800
#FLUX: --priority=16

source ../../../../pytorch-1.11/bin/activate
module load gcc/8.2.0 python_gpu/3.10.4
rsync -aP /cluster/work/cvl/tiazhou/data/medical/FL/ProstateMRI.zip ${TMPDIR}/
unzip -q ${TMPDIR}/ProstateMRI.zip -d ${TMPDIR}/ProstateMRI
cd ../../../
trial=0
train_ratio=0.1
python main.py --config 'config.prostate_mri.fedsam' \
               --server 'euler' \
               --trial $trial \
               --train_ratio $train_ratio \
               --run_name 'fedsam_ratio_'$train_ratio'trial_'$trial \
               --run_notes 'trial '$trial': fedsam' \
               --exp_name 'fedsam'
