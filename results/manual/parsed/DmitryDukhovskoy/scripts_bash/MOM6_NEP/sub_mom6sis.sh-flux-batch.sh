#!/bin/bash
#FLUX: --job-name=NEP_BGCphys
#FLUX: -N=16
#FLUX: --queue=batch
#FLUX: -t=28800
#FLUX: --priority=16

export HEXE='fms_MOM6_SIS2_GENERIC_4P_compile_symm.x'

set -eux
echo -n " $( date +%Y%m%d-%H:%M:%S )," >  job_timestamp.txt
set +x
echo "Model started:  " `date`
export HEXE=fms_MOM6_SIS2_GENERIC_4P_compile_symm.x
sync && sleep 1
/usr/bin/srun --ntasks=2036 --cpus-per-task=1 --export=ALL ./${HEXE}
echo "Model ended:    " `date`
echo -n " $( date +%s )," >> job_timestamp.txt
