#!/bin/bash
#FLUX: --job-name=hairy-arm-5766
#FLUX: --urgency=16

eval $(spack load --sh py-s3cmd@2.3.0)
read s3Path data_dir < <(sed -n ${SLURM_ARRAY_TASK_ID}p $1)
mkdir -p ${data_dir}
s3cmd get ${s3Path} ${data_dir}/
