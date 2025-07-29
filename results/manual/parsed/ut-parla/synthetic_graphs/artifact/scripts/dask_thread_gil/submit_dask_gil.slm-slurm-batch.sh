#!/bin/bash
#SBATCH --job-name=dg2
#SBATCH --account=ASC21002
#SBATCH --output=dg2.o%j
#SBATCH --error=dg2.e%j
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=05:00:00

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
