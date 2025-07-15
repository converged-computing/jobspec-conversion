#!/bin/bash
#FLUX: --job-name=misunderstood-lemon-5339
#FLUX: --priority=16

sleep 10s 
module load matlab
cd $MYDIR/Examples/MultiSubjectICA
matlab -batch 'gigica_step2'
sleep 10s
