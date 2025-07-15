#!/bin/bash
#FLUX: --job-name=phat-parrot-2087
#FLUX: --urgency=16

eval $(spack load --sh miniconda3)
source activate active-learning
if [ -z ${SLURM_ARRAY_TASK_ID} ] ; then
    fold=1
else
    fold=${SLURM_ARRAY_TASK_ID}
fi
dirname=ModelFitting/K562/OneRound/${fold}
mkdir -p $dirname
python3 src/cnn_k562_classification_sampling.py $dirname --fold $fold --upper_bound --sampling_size 5000 3000 1000 --initial_data 5000
python3 src/cnn_k562_classification_sampling.py $dirname --fold $fold --sampling_size 5000 3000 1000 --initial_data 4000
python3 src/cnn_k562_classification_sampling.py $dirname --fold $fold --sampling_size 5000 3000 1000 --initial_data 3000
