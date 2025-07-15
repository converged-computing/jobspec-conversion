#!/bin/bash
#FLUX: --job-name=ngon
#FLUX: -t=5
#FLUX: --priority=16

module load python/3.8.5
data_file='input_data.txt'
n=$(sed -n ${SLURM_ARRAY_TASK_ID}p ${data_file})
echo "I'm array job number ${SLURM_ARRAY_TASK_ID}"
echo "My n-gon number is ${n}"
python3 paralProg/area_of_ngon.py --out ${n}-gon.txt ${n}
