#!/bin/bash
#FLUX: --job-name=HM.2s5r
#FLUX: -N=2
#FLUX: --queue=long1
#FLUX: -t=172800
#FLUX: --urgency=16

module load gnu8/8.3.0
module load mkl/19.1.3.304
module load openmpi3/3.1.4
module load matlab/2021a
START_TIME=`date +%H:%M-%a-%d/%b/%Y`
echo '------------------------------------------------------'
echo 'This job is allocated on '$SLURM_JOB_CPUS_PER_NODE' cpu(s)'
echo 'Job is running on node(s): '
echo  $SLURM_JOB_NODELIST
echo '------------------------------------------------------'
echo 'WORKINFO:'
echo 'SLURM: job starting at           '$START_TIME
echo 'SLURM: sbatch is running on      '$SLURM_SUBMIT_HOST
echo 'SLURM: executing on cluster      '$SLURM_CLUSTER_NAME
echo 'SLURM: executing on partition    '$SLURM_JOB_PARTITION
echo 'SLURM: working directory is      '$SLURM_SUBMIT_DIR
echo 'SLURM: current home directory is '$(getent passwd $SLURM_JOB_ACCOUNT | cut -d: -f6)
echo ""
echo 'JOBINFO:'
echo 'SLURM: job identifier is         '$SLURM_JOBID
echo 'SLURM: job name is               '$SLURM_JOB_NAME
echo ""
echo 'NODEINFO:'
echo 'SLURM: number of nodes is        '$SLURM_JOB_NUM_NODES
echo 'SLURM: number of cpus/node is    '$SLURM_JOB_CPUS_PER_NODE
echo 'SLURM: number of gpus/node is    '$SLURM_GPUS_PER_NODE
echo '------------------------------------------------------'
cd $SLURM_SUBMIT_DIR # Brings the shell into the directory from which you’ve submitted the script.
matlab -batch "runDMFT.dry_line('cdn_hm_2dsquare_fit_overhaul',true,NaN,0,0.1,8)"
echo "Waiting for all the processes to finish..."
wait
