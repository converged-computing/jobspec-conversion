#!/bin/bash
#FLUX: --job-name=fuzzy-milkshake-3224
#FLUX: --queue=gpu
#FLUX: -t=259200
#FLUX: --urgency=16

echo STARTING AT $(date)
module purge
source /ssoft/spack/bin/slmodules.sh -s x86_E5v2_Mellanox_GPU
module load gcc cuda cudnn python mvapich2
source /home/amjakob/venvs/tensorflow-1.9/bin/activate
time srun python train_classification_tl_aux.py --ckpt_load=keras_swisspv_untrained_aux.h5 --epochs=200 --batch_size=100 --epochs_ckpt=5 --train_set=train.pickle --test_set=test.pickle --validation_split=0.1 --skip_train=False --skip_test=False --fine_tune_layers=8 --verbose=1
deactivate
echo FINISHED AT $(date)
