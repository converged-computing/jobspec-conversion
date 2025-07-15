#!/bin/bash
#FLUX: --job-name=stanky-malarkey-6605
#FLUX: --urgency=16

source /scratch1/06081/wlruys/miniconda3/etc/profile.d/conda.sh
conda activate rap
module list
pwd
date
n=1000
for rep in 1 2 3 4 5
do
    for n in $(seq 100 100 5000);
    do
        first=0
        for size in 0
        do
            for work in 20;
            do
                python_output=`python dask_thread.py -workers ${work} -time ${size} -n ${n}`
                last=`echo ${python_output} | awk -F "," '{print $NF}'`
                echo "$n, $python_output"
                if [ $work -eq "1" ]; then
                    first=$last
                fi
                if (( $(echo "$last > $first" |bc -l) )); then
                    break
                fi
            done
        done
    done
done
