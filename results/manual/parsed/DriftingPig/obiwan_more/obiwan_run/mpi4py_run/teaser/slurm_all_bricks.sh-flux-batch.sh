#!/bin/bash
#FLUX: --job-name=red-bike-7971
#FLUX: --urgency=16

export name_for_run='elg_new_ccd_list'
export randoms_db='None #run from a fits file'
export dataset='dr3'
export rowstart='0'
export do_skipids='no'
export do_more='yes'
export minid='1'
export object='elg'
export nobj='1000'
export usecores='8'
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

export name_for_run=elg_new_ccd_list
export randoms_db=None #run from a fits file
export dataset=dr3
export rowstart=0
export do_skipids=no
export do_more=yes
export minid=1
export object=elg
export nobj=1000
export usecores=8
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
srun -N 1 -n 8 -c $usecores shifter ./example1.sh
wait
