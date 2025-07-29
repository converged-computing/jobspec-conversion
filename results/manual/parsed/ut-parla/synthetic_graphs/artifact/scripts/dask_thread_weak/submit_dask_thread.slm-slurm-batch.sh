#!/bin/bash
#SBATCH --job-name=dtw
#SBATCH --account=ASC21002
#SBATCH --output=dtw.o%j
#SBATCH --error=dtw.e%j
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=05:00:00

source /scratch1/06081/wlruys/miniconda3/etc/profile.d/conda.sh
conda activate rap
module list
pwd
date
per=50
for rep in 1 2 3 4 5
do
    first=0
    for size in 800 1600 3200 6400 12800 25600 51200 102400
    do
        for work in $(seq 1 1 4; seq 5 5 55);
        do
            n=$((per*work))
            python_output=`python dask_thread.py -workers ${work} -time ${size} -n ${n}`
            last=`echo ${python_output} | awk -F "," '{print $NF}'`
            echo $python_output
            if [ $work -eq "1" ]; then
                first=`echo $last*20 | bc`
            fi
            if (( $(echo "$last > $first" |bc -l) )); then
                break
            fi
        done
    done
done
