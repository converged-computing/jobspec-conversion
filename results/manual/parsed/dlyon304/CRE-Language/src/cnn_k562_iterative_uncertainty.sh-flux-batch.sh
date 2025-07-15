#!/bin/bash
#FLUX: --job-name=muffled-citrus-4047
#FLUX: -t=0
#FLUX: --urgency=16

eval $(spack load --sh miniconda3)
source activate active-learning
if [ -z ${SLURM_ARRAY_TASK_ID} ] ; then
    fold=1
    runname=${SLURM_JOB_ID}
else
    fold=${SLURM_ARRAY_TASK_ID}
    runname=${SLURM_ARRAY_JOB_ID}
fi
dirname=iter_${runname}/${fold}
mkdir -p $dirname
init=10000
inc=3000
python3 src/cnn_k562_iterative_uncertainty.py Data/K562/ $dirname --fold ${fold} --sampling_size ${inc} --initial_size ${init} --iterations 0
