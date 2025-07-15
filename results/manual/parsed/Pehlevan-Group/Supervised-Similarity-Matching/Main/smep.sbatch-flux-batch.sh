#!/bin/bash
#FLUX: --job-name=eccentric-carrot-9260
#FLUX: --priority=16

module load <insert Anaconda module name>
module load <insert cuda module name>
source activate theano_env 
THEANO_FLAGS="device=cuda, floatX=float32, gcc.cxxflags='-march=core2'" python mod_exp_smep_tmp2.py ${SLURM_ARRAY_TASK_ID} 'new' 'smep' 'mnist'
