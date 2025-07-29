#!/bin/bash
#SBATCH --job-name=NEP_BGCphys
#SBATCH --account=cefi
#SBATCH --output=%x.o%j
#SBATCH --error=err
#SBATCH --nodes=16
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=08:00:00
#SBATCH --partition=batch
#SBATCH --qos=normal

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
