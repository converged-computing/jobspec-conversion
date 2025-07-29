#!/bin/bash
#SBATCH --job-name=recheck_adaptrerr
#SBATCH --output=Recheck/adap_trerr_%A_%a.o
#SBATCH --error=Recheck/adap_trerr_%A_%a.e
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=6000
#SBATCH --time=2-00:00:00

module load <insert Anaconda module name>
module load <insert cuda module name>
source activate theano_env 
THEANO_FLAGS="device=cuda, floatX=float32, gcc.cxxflags='-march=core2'" python mod_exp_smep_tmp2.py ${SLURM_ARRAY_TASK_ID} 'new' 'smep' 'mnist'
