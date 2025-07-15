#!/bin/bash
#FLUX: --job-name=example1_job
#FLUX: --queue=7452
#FLUX: -t=21600
#FLUX: --urgency=16

echo Job started on `hostname` `date`
src=/home/richard.uconn/gluex-osg-jobscripts
dst=/home/richard.uconn/sandbox/job_${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID}
mkdir -p $dst
for f in osg-container.sh example1.py; do
    cp $src/$f $dst
done
module load singularity
cd $dst
./osg-container.sh python example1.py doslice $SLURM_ARRAY_TASK_ID 0
echo Job ending `date`
