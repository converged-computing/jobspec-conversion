#!/bin/bash
#FLUX: --job-name=moolicious-carrot-7370
#FLUX: --priority=16

export name_for_run='elg_eight_bricks'
export randoms_db='None #run from a fits file'
export dataset='dr3'
export rowstart='201'
export do_skipids='no'
export do_more='yes'
export minid='1'
export object='elg'
export nobj='1000'
export usecores='64'
export threads='$usecores'
export CSCRATCH_OBIWAN='$CSCRATCH/obiwan_Aug/repos_for_docker'
export obiwan_data='$CSCRATCH_OBIWAN/obiwan_data '
export obiwan_code='$CSCRATCH_OBIWAN/obiwan_code '
export obiwan_out='$CSCRATCH_OBIWAN/obiwan_out   '
export LEGACY_SURVEY_DIR='$obiwan_data/legacysurveydir_dr3'
export KMP_AFFINITY='disabled'
export MPICH_GNI_FORK_MODE='FULLCOPY'
export MKL_NUM_THREADS='1'
export OMP_NUM_THREADS='1'
export XDG_CONFIG_HOME='/dev/shm'

export name_for_run=elg_eight_bricks
export randoms_db=None #run from a fits file
export dataset=dr3
export rowstart=201
export do_skipids=no
export do_more=yes
export minid=1
export object=elg
export nobj=1000
export usecores=64
export threads=$usecores
export CSCRATCH_OBIWAN=$CSCRATCH/obiwan_Aug/repos_for_docker
export obiwan_data=$CSCRATCH_OBIWAN/obiwan_data 
export obiwan_code=$CSCRATCH_OBIWAN/obiwan_code 
export obiwan_out=$CSCRATCH_OBIWAN/obiwan_out   
export LEGACY_SURVEY_DIR=$obiwan_data/legacysurveydir_dr3
export KMP_AFFINITY=disabled
export MPICH_GNI_FORK_MODE=FULLCOPY
export MKL_NUM_THREADS=1
export OMP_NUM_THREADS=1
export XDG_CONFIG_HOME=/dev/shm
srun -n $SLURM_JOB_NUM_NODES mkdir -p $XDG_CONFIG_HOME/astropy
echo $1
srun -N 1 -n 1 -c $usecores shifter ./slurm_brick_scheduler.sh $1
wait
