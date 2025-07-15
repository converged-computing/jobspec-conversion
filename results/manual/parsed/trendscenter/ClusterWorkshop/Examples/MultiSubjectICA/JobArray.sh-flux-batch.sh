#!/bin/bash
#FLUX: --job-name=boopy-puppy-7254
#FLUX: --urgency=16

sleep 10s 
module load matlab
cd $MYDIR/Examples/MultiSubjectICA
matlab -batch 'gigica_step2'
sleep 10s
