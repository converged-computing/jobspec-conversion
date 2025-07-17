#!/bin/bash
#FLUX: --job-name=om2-v12
#FLUX: --queue=intel
#FLUX: -t=4060800
#FLUX: --urgency=16

export OMP_NUM_THREADS='8,1'
export PATH='$PATH:/tmp/$user/qms$SLURM_JOB_NAME${SLURM_ARRAY_TASK_ID}'
export MOLCAS_MEM='32000'
export Project='TMP.${SLURM_ARRAY_TASK_ID}'
export WorkDir='/tmp/$user/qms$SLURM_JOB_NAME${SLURM_ARRAY_TASK_ID}/'

unlog
aklog
export OMP_NUM_THREADS=8,1
workdir=$1
user=$2
if [ -z $user ]
then
user=swang
echo "user" $user
fi
if [ -z $workdir ]
then
workdir="${pwd}"
echo "default workdir" $workdir
fi
cd $workdir$SLURM_JOB_NAME/TMPQCEIMS/TMP.${SLURM_ARRAY_TASK_ID}
echo "Job started at " `date`
echo ''
module load mndo99/2017
echo  $HOSTNAME
echo ''
lscpu
echo ''
echo 'jobid: '${SLURM_JOB_ID}
echo ''
if [ ! -f /tmp/$user/qms$SLURM_JOB_NAME${SLURM_ARRAY_TASK_ID}/qceims ]; then
	# create custom qceims for a specific user // folder name is hardcoded for each user
	mkdir -p /tmp/$user/qms$SLURM_JOB_NAME${SLURM_ARRAY_TASK_ID}/
	# copy qceims work files to /qms
	cp /share/fiehnlab/users/shunyang/xstate_project/qceims/molcas/qceims_mndo /tmp/$user/qms$SLURM_JOB_NAME${SLURM_ARRAY_TASK_ID}/qceims
	# change the executable mode
	chmod +x /tmp/$user/qms$SLURM_JOB_NAME${SLURM_ARRAY_TASK_ID}/qceims
fi
cd /tmp/$user/qms$SLURM_JOB_NAME${SLURM_ARRAY_TASK_ID}/
ls -la
export PATH=$PATH:/tmp/$user/qms$SLURM_JOB_NAME${SLURM_ARRAY_TASK_ID}
export MOLCAS_MEM=32000
cd $workdir$SLURM_JOB_NAME/TMPQCEIMS/TMP.${SLURM_ARRAY_TASK_ID}
export Project=TMP.${SLURM_ARRAY_TASK_ID}
export WorkDir=/tmp/$user/qms$SLURM_JOB_NAME${SLURM_ARRAY_TASK_ID}/
cp $workdir$SLURM_JOB_NAME/mndo.opt $workdir$SLURM_JOB_NAME/TMPQCEIMS/TMP.${SLURM_ARRAY_TASK_ID}
cp $workdir$SLURM_JOB_NAME/qceims.in $workdir$SLURM_JOB_NAME/TMPQCEIMS/TMP.${SLURM_ARRAY_TASK_ID}
dft=false
if $dft ;then
echo orca > qceims.in
echo mo-orca >> qceims.in
echo pbe0 >> qceims.in
echo SV\(P\) >> qceims.in
echo ip-orca >> qceims.in
fi
qceims -p -qcp /software/mndo99/2017/lssc0-linux/ > qceims.out 2>&1
wait
rm RUNNING
touch FINISHED
rm -rf /tmp/$user/qms$SLURM_JOB_NAME${SLURM_ARRAY_TASK_ID}/
echo "Job ended at " `date`
