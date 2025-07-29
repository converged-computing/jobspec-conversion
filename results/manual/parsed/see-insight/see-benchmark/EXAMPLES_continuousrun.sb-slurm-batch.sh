#!/bin/bash
#SBATCH --job-name=SEE-continuous
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=6gb
#SBATCH --time=04:00:00
#SBATCH --array=1-150

cd see-segment; git log -n 1; cd ..
echo "Continuous Run Number $SLURM_ARRAY_TASK_ID"
timeout 14100s singularity exec -B /usr/bin/:/sysbin/ \
                 --env PATH=/miniconda3/bin/:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/sysbin/ \
                 --writable-tmpfs \
                 --env-file /opt/software/powertools/share/jupyter.env \
                 centos7.sif \
                 ./EXAMPLES_run.sh $SLURM_ARRAY_TASK_ID $(( $SLURM_ARRAY_TASK_ID + $SLURM_JOB_ID )) coninuousrun
out=$?
echo "CHECKING FOR ERRORS"
if [ "$out" == "124" ] #TIMEOUT REACHED
then
    echo "Timeout...RESTARTING $out"
    sbatch --array=${SLURM_ARRAY_TASK_ID} continuousrun.sb 
else
    echo "ERROR: $out - NO RESTART"
fi
