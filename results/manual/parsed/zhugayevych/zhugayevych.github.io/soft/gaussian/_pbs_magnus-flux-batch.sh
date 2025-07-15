#!/bin/bash
#FLUX: --job-name=hairy-squidward-6416
#FLUX: --urgency=16

export GAUSS_MEMDEF='$((MemBytes*95/8/100))'
export GAUSS_PDEF='${SLURM_CPUS_PER_TASK}'
export GAUSS_SCRDIR='/scr/$SLURM_JOB_USER/$SLURM_JOB_ID'

echo 'JOB_NAME' $SLURM_JOB_NAME
echo 'JOB_ID' $SLURM_JOB_ID
echo 'JOB_CPUS_PER_NODE' $SLURM_JOB_CPUS_PER_NODE
hostname
date
module load Q-Ch/Gaussian/16.RevA03
MemBytes=`cat /sys/fs/cgroup/memory/slurm/uid_${UID}/job_${SLURM_JOBID}/memory.limit_in_bytes`
export GAUSS_MEMDEF=$((MemBytes*95/8/100))
export GAUSS_PDEF=${SLURM_CPUS_PER_TASK}
export GAUSS_SCRDIR=/scr/$SLURM_JOB_USER/$SLURM_JOB_ID
echo 'GAUSS_MEMDEF' $GAUSS_MEMDEF
echo 'GAUSS_PDEF' $GAUSS_PDEF
echo 'GAUSS_SCRDIR' $GAUSS_SCRDIR
cd ~/gaussian
sed -e "/nprocshared/d;/mem/d" -i $SLURM_JOB_NAME.gau
g16 < $SLURM_JOB_NAME.gau > $SLURM_JOB_NAME.out
date
rm -f ~/$SLURM_JOB_NAME.e$SLURM_JOB_ID.err
