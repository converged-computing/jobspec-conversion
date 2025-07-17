#!/bin/bash
#FLUX: --job-name=recheck_adaptrerr
#FLUX: --queue=<insert_partition>
#FLUX: -t=172800
#FLUX: --urgency=16

module load <insert Anaconda module name>
module load <insert cuda module name>
source activate theano_env 
THEANO_FLAGS="device=cuda, floatX=float32, gcc.cxxflags='-march=core2'" python mod_exp_smep_tmp2.py ${SLURM_ARRAY_TASK_ID} 'new' 'smep' 'mnist'
