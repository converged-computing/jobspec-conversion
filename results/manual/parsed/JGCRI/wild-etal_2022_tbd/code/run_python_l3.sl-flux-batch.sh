#!/bin/bash
#FLUX: --job-name=an2month
#FLUX: -t=10800
#FLUX: --urgency=16

module purge
module load gcc/8.1.0
module load gdal/2.3.1
module load python/3.7.2
module load R/3.4.3
source /people/d3y010/virtualenvs/py3.7.2_an2month/bin/activate
START=`date +%s`
python /people/d3y010/an2month/code/python_l3.py $SLURM_ARRAY_TASK_ID
END=`date +%s`
RUNTIME=$(($END-$START))
echo $RUNTIME
