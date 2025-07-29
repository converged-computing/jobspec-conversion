#!/bin/bash
#SBATCH --job-name=pull_from_s3
#SBATCH --output=pull_from_s3.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=100M

eval $(spack load --sh py-s3cmd@2.3.0)
read s3Path data_dir < <(sed -n ${SLURM_ARRAY_TASK_ID}p $1)
mkdir -p ${data_dir}
s3cmd get ${s3Path} ${data_dir}/
