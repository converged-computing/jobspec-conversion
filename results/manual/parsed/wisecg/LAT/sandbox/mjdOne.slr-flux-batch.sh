#!/bin/bash
#FLUX: --job-name=pulse1-haswell
#FLUX: -N=4
#FLUX: -c=64
#FLUX: --queue=debug
#FLUX: -t=1800
#FLUX: --urgency=16

export OMP_NUM_THREADS='64'
export OMP_PROC_BIND='true'
export OMP_PLACES='threads'
export RUN2='${1-16846}'

job_sh=./mjdInShifter.sh
echo start-A
env|grep  SHIFTER_RUNTIME
ls -l  ${job_sh}
export OMP_NUM_THREADS=64
export OMP_PROC_BIND=true
export OMP_PLACES=threads
echo "enter cgroup ----"
srun -N 4 -n 4 -c 64 shifter  --volume=/global/project:/project /bin/bash ${job_sh}
echo "returned from cgroup ----"
echo end-A
job_sh=mjrTask.sh
export RUN2=${1-16846}
echo "start-A "`hostname`"  RUN2="$RUN2
ls -l  ${job_sh}
if [[ $SLURM_JOB_PARTITION == *"-chos" ]]
then
  echo  run-in-chos
  CHOS=sl64 chos  ./${job_sh}
else
 echo  run-in-shifter
 shifter  --volume=/global/project:/project  /bin/bash ${job_sh}
fi
echo end-A
