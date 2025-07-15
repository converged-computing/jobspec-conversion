#!/bin/bash
#FLUX: --job-name=bricky-rabbit-7689
#FLUX: -t=172800
#FLUX: --urgency=16

source ../../../../pytorch-1.11/bin/activate
module load gcc/8.2.0 python_gpu/3.10.4
rsync -aP /cluster/work/cvl/tiazhou/data/medical/FL/office_caltech_10_dataset.zip ${TMPDIR}/
unzip -q ${TMPDIR}/office_caltech_10_dataset.zip -d ${TMPDIR}/
cd ../../../
trial=1
python main.py --config 'config.office.fedavg' \
               --server 'euler' \
               --trial $trial \
               --run_name 'fedavg_trial_'$trial \
               --run_notes 'trial '$trial': fedavg' \
               --exp_name 'fedavg'
