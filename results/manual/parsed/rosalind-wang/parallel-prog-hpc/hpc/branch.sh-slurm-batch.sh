#!/bin/bash
#SBATCH --job-name=ngon
#SBATCH --output=ngon_%A-%a_out.txt
#SBATCH --error=ngon_%A-%a_err.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=1G
#SBATCH --time=00:00:05
#SBATCH --array=1-6

module load python/3.8.5
data_file='input_data.txt'
n=$(sed -n ${SLURM_ARRAY_TASK_ID}p ${data_file})
echo "I'm array job number ${SLURM_ARRAY_TASK_ID}"
echo "My n-gon number is ${n}"
python3 paralProg/area_of_ngon.py --out ${n}-gon.txt ${n}
