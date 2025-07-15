#!/bin/bash
#FLUX: --job-name=doopy-peas-4439
#FLUX: --urgency=16

export name_for_run='chunk21_new_calib'
export name_for_randoms='sgc_brick_dat_2'
export randoms_db='None #run from a fits file'
export dataset='dr3'
export rowstart='0'
export do_skipids='no'
export do_more='yes'
export minid='1'
export object='elg'
export nobj='100'
export usecores='32'
export threads='$usecores'
export CSCRATCH_OBIWAN='$CSCRATCH/obiwan_Aug/repos_for_docker'
export obiwan_data='$CSCRATCH_OBIWAN/obiwan_data '
export obiwan_code='$CSCRATCH_OBIWAN/obiwan_code '
export obiwan_out='$CSCRATCH_OBIWAN/obiwan_out   '
export LEGACY_SURVEY_DIR='/global/cscratch1/sd/huikong/obiwan_Aug/repos_for_docker/obiwan_data/new_calibs/DR3_copies0/legacysurveydir_dr3_copy1'
export KMP_AFFINITY='disabled'
export MPICH_GNI_FORK_MODE='FULLCOPY'
export MKL_NUM_THREADS='1'
export OMP_NUM_THREADS='1'
export XDG_CONFIG_HOME='/dev/shm'

export name_for_run=chunk21_new_calib
export name_for_randoms=sgc_brick_dat_2
export randoms_db=None #run from a fits file
export dataset=dr3
export rowstart=0
export do_skipids=no
export do_more=yes
export minid=1
export object=elg
export nobj=100
export usecores=32
export threads=$usecores
export CSCRATCH_OBIWAN=$CSCRATCH/obiwan_Aug/repos_for_docker
export obiwan_data=$CSCRATCH_OBIWAN/obiwan_data 
export obiwan_code=$CSCRATCH_OBIWAN/obiwan_code 
export obiwan_out=$CSCRATCH_OBIWAN/obiwan_out   
export LEGACY_SURVEY_DIR=/global/cscratch1/sd/huikong/obiwan_Aug/repos_for_docker/obiwan_data/new_calibs/DR3_copies0/legacysurveydir_dr3_copy1
export KMP_AFFINITY=disabled
export MPICH_GNI_FORK_MODE=FULLCOPY
export MKL_NUM_THREADS=1
export OMP_NUM_THREADS=1
export XDG_CONFIG_HOME=/dev/shm
srun -n $SLURM_JOB_NUM_NODES mkdir -p $XDG_CONFIG_HOME/astropy
srun -N 20 -n 40 -c $usecores shifter ./example1.sh
wait
