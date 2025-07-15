#!/bin/bash
#FLUX: --job-name=rainbow-cupcake-4066
#FLUX: --priority=16

source /scratch1/06081/wlruys/miniconda3/etc/profile.d/conda.sh
conda activate rap
module list
pwd
date
n=5000
for rep in 1 2 3 4 5
do
    first=0
    for size in 800 1600 3200 6400 12800 25600 51200 102400
    do
        for work in $(seq 1 1 4; seq 5 5 55);
        do
            python_output=`python dask_process.py -workers ${work} -time ${size} -n ${n}`
            last=`echo ${python_output} | awk -F "," '{print $NF}'`
            echo $python_output
            if [ $work -eq "1" ]; then
                first=$last
            fi
            if (( $(echo "$last > $first" |bc -l) )); then
                break
            fi
        done
    done
done
