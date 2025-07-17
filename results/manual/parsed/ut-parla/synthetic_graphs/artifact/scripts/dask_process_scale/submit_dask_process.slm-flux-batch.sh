#!/bin/bash
#FLUX: --job-name=dpsc
#FLUX: --queue=small
#FLUX: -t=18000
#FLUX: --urgency=16

source /scratch1/06081/wlruys/miniconda3/etc/profile.d/conda.sh
conda activate rap
module list
pwd
date
for rep in 1 2 3 4 5
do
    for n in $(seq 100 100 5000);
    do
        first=0
        for size in 0
        do
            for work in 20;
            do
                python_output=`python dask_process.py -workers ${work} -time ${size} -n ${n}`
                last=`echo ${python_output} | awk -F "," '{print $NF}'`
                echo "$n, $python_output"
            done
        done
    done
done
