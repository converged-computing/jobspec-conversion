#!/bin/bash
#FLUX: --job-name=fat-buttface-2997
#FLUX: -t=0
#FLUX: --priority=16

eval $(spack load --sh miniconda3)
source activate active-learning
if [ -z ${SLURM_ARRAY_TASK_ID} ] ; then
    fold=1
else
    fold=${SLURM_ARRAY_TASK_ID}
fi
basedir=ModelFitting/K562/ManyRounds/
dirname=${basedir}/init_4000_inc_2000/${fold}
mkdir -p $dirname
python3 src/cnn_k562_iterative_uncertainty.py $dirname --fold ${fold} --sampling_size 2000 --initial_size 4000 --iterations 0
dirname=${basedir}/init_10000_inc_3000/${fold}
mkdir -p $dirname
python3 src/cnn_k562_iterative_uncertainty.py $dirname --fold ${fold} --sampling_size 3000 --initial_size 10000 --iterations 0
