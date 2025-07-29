#!/bin/bash
#FLUX: --job-name=TIESanalysis
#FLUX: --queue=test
#FLUX: -t=1800
#FLUX: --urgency=16

module load slurm_setup
module load python/3.6_intel
for D in */;
do
    cd $D
    echo "Next Dir: $D"
        python ../ddg.py > ddg.out &
    cd ..
done
wait
