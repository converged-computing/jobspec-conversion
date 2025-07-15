#!/bin/bash
#FLUX: --job-name=frigid-signal-8801
#FLUX: -t=180
#FLUX: --priority=16

folder=`pwd`
tstamp=`date +%d-%m-%Y_%H%M`
module load tryton/matlab/2017a
matlab -nodisplay -nodesktop -logfile $folder/logfile_${tstamp}.log  <  $folder/test_rng_cvpart.m
