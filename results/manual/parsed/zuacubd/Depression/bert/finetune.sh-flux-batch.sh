#!/bin/bash
#FLUX: --job-name=Finetune_imbalanced_bert_2017
#FLUX: -c=4
#FLUX: --queue=GPUNodes
#FLUX: --urgency=16

track_year=$1
echo "starting ..."
srun singularity exec /logiciels/containerCollections/CUDA11/pytorch-NGC-20-06-py3.sif /users/sig/mullah/.conda/envs/e36t11/bin/python fine_tuning.py $track_year
echo "done."
