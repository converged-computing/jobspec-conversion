#!/bin/bash
#FLUX: --job-name=blue-mango-5162
#FLUX: --queue=gpu
#FLUX: -t=259200
#FLUX: --urgency=16

echo STARTING AT $(date)
module purge
source /ssoft/spack/bin/slmodules.sh -s x86_E5v2_Mellanox_GPU
module load gcc cuda cudnn python mvapich2
source /home/amjakob/venvs/tensorflow-1.9/bin/activate
time srun python train_segmentation_tl.py --two_layers=False --second_layer_from_ckpt=False --epochs=100 --epochs_ckpt=50 --batch_size=100 --train_set=train.pickle --test_set=test.pickle --skip_test=True
time srun python train_segmentation_tl.py --two_layers=True --second_layer_from_ckpt=False --epochs=100 --epochs_ckpt=50 --batch_size=100 --train_set=train.pickle --test_set=test.pickle --skip_test=False
deactivate
echo FINISHED AT $(date)
