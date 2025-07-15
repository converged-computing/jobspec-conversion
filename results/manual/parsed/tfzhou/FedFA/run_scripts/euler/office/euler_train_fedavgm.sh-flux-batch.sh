#!/bin/bash
#FLUX: --job-name=lovable-peanut-3284
#FLUX: -t=172800
#FLUX: --priority=16

source ../../../../pytorch-1.11/bin/activate
module load gcc/8.2.0 python_gpu/3.10.4
rsync -aP /cluster/work/cvl/tiazhou/data/medical/FL/office_caltech_10_dataset.zip ${TMPDIR}/
unzip ${TMPDIR}/office_caltech_10_dataset.zip -d ${TMPDIR}/
cd ../../../
trial=0
python main.py --config 'config.office.fedavgm' \
               --server 'euler' \
               --trial $trial \
               --run_name 'fedavgm_trial_'$trial \
               --run_notes 'trial '$trial': fedavgm' \
               --exp_name 'fedavgm'
