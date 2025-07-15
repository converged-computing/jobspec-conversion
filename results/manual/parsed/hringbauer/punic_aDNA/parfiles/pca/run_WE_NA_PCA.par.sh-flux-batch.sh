#!/bin/bash
#FLUX: --job-name=stinky-puppy-2328
#FLUX: --queue=priority
#FLUX: --priority=16

LD_LIBRARY_PATH=/opt/lsf/7.0/linux2.6-glibc2.3-x86_64/lib:/opt/nag/libC/lib:/usr/lib
NAG_KUSARI_FILE=/opt/nag/nag.license
LM_LICENSE_FILE=/opt/nag/license.dat
module load gcc
module load gsl/2.3
module load openblas
module load graphviz
module load fftw
PATH="$PATH:~np29/o2bin"
PATH="$PATH:/n/groups/reich/iosif/sw/fs-2.0.7"
PATH="$PATH:/n/groups/reich/iosif/sw/msdir/msdir"
TDIR="/n/scratch2/am483"
PFILE="/n/groups/reich/hringbauer/git/punic_aDNA/parfiles/pca/run_WE_NA_PCA.v54.1.par"
~np29/o2bin/smartpca -p $PFILE
