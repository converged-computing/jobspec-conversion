#!/bin/bash
#FLUX: --job-name=mmsrl
#FLUX: -c=10
#FLUX: -t=18000
#FLUX: --urgency=16

export DATA_PATH='$WORK/data'

cd $WORK/mmsrl
module purge
source ~/.bashrc
conda activate pytorch
export DATA_PATH=$WORK/data
TASK=('configs/ofa_vqa.py' 'configs/ofa_snli.py')
PARAMS=('configs/ofa_repo.py' 'configs/ofa_ours.py' 'configs/ofa_ours.py --freeze_resnet --freeze_embeddings')
CYCLE=('--subsample_labels=affine --frequency_factor=0.1 --frequency_bias=0.05' 'configs/alternate_macro_micro.py' 'configs/alternate_macro_micro.py --cyclic_subsample=cyclic_subsample_longer')
HEAD=('--ofa_classification_head=False' '--ofa_classification_head=True')
itask=$(($SLURM_ARRAY_TASK_ID%2))
iparams=$(($SLURM_ARRAY_TASK_ID%6/2))
icycle=$(($SLURM_ARRAY_TASK_ID%18/6))
ihead=$(($SLURM_ARRAY_TASK_ID/18))
task=${TASK[$itask]}
params=${PARAMS[$iparams]}
cycle=${CYCLE[$icycle]}
head=${HEAD[$ihead]}
python -m mmsrl.train $task $params $cycle $head --patience=10 --output_val=\"val_${itask}_${iparams}_${icycle}_${ihead}.pkl\" --output_test=\"test_${itask}_${iparams}_${icycle}_${ihead}.pkl\"
