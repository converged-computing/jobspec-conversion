#!/bin/bash
#FLUX: --job-name=crunchy-carrot-0347
#FLUX: --urgency=16

source /scratch1/06081/wlruys/miniconda3/etc/profile.d/conda.sh
conda activate rap
module list
pwd
date
n=1000
for rep in 1 2 3 4 5
do
    for gil in 500 1000 2500 5000 10000 25000 40000
    do
        size=$((50000-gil))
        for work in $(seq 1 1 4; seq 5 5 50);
        do
            python_output=`python dask_thread.py -workers ${work} -time ${size} -n ${n} -gtime ${gil}`
            echo "$gil, $python_output"
        done
    done
done
