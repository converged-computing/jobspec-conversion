#!/bin/bash
#FLUX: --job-name=CAAEfromscratch
#FLUX: --queue=csgpu
#FLUX: --priority=16

cd $SLURM_SUBMIT_DIR
cd Face_Aging_CAAE_10age
module load tensorflowgpu
python main.py --is_train True --dataset ../DATA/TrainingSet_CACD2000 --savedir save --use_trained_model false --use_init_model false
