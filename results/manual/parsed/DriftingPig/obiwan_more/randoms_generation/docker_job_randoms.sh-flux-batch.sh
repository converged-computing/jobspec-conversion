#!/bin/bash
#FLUX: --job-name=strawberry-animal-5020
#FLUX: --priority=16

export CSCRATCH_OBIWAN='/global/cscratch1/sd/huikong/obiwan_Aug/repos_for_docker'
export PYTHONPATH='$CSCRATCH_OBIWAN/obiwan_code/py:$CSCRATCH_OBIWAN/legacypipe/py:$PYTHONPATH'
export obiwan_data='$CSCRATCH_OBIWAN/obiwan_data'
export obiwan_code='$CSCRATCH_OBIWAN/obiwan_code'
export obiwan_out='$CSCRATCH_OBIWAN/obiwan_out'
export outdir='$CSCRATCH_OBIWAN/obiwan_out/eboss_elg/randoms_test_2'
export survey='eboss'
export startid='77060581 #1618001'
export max_prev_seed='65'
export nrandoms='66248860 #418000'
export ra1='316.5'
export ra2='360.'
export dec1='-2.'
export dec2='2.'
export KMP_AFFINITY='disabled'
export MPICH_GNI_FORK_MODE='FULLCOPY'
export MKL_NUM_THREADS='1'
export OMP_NUM_THREADS='1'
export XDG_CONFIG_HOME='/dev/shm'
export tasks='16'

source /global/cscratch1/sd/huikong/obiwan_Aug/repos_for_docker/bashrc_obiwan
export CSCRATCH_OBIWAN=/global/cscratch1/sd/huikong/obiwan_Aug/repos_for_docker
export PYTHONPATH=$CSCRATCH_OBIWAN/obiwan_code/py:$CSCRATCH_OBIWAN/legacypipe/py:$PYTHONPATH
export obiwan_data=$CSCRATCH_OBIWAN/obiwan_data
export obiwan_code=$CSCRATCH_OBIWAN/obiwan_code
export obiwan_out=$CSCRATCH_OBIWAN/obiwan_out
export outdir=$CSCRATCH_OBIWAN/obiwan_out/eboss_elg/randoms_test_2
export survey=eboss
export startid=77060581 #1618001
export max_prev_seed=65
export nrandoms=66248860 #418000
export ra1=316.5
export ra2=360.
export dec1=-2.
export dec2=2.
export KMP_AFFINITY=disabled
export MPICH_GNI_FORK_MODE=FULLCOPY
export MKL_NUM_THREADS=1
export OMP_NUM_THREADS=1
export XDG_CONFIG_HOME=/dev/shm
srun -n $SLURM_JOB_NUM_NODES mkdir -p $XDG_CONFIG_HOME/astropy
export tasks=16
srun -n ${tasks} -c 2 shifter ./docker_job_randoms_init.sh
