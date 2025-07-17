#!/bin/bash
#FLUX: --job-name=cworkshop_multi_ica
#FLUX: --queue=qTRD
#FLUX: -t=3600
#FLUX: --urgency=16

sleep 10s 
module load matlab
cd $MYDIR/Examples/MultiSubjectICA
matlab -batch 'gigica_step2'
sleep 10s
