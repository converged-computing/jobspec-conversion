#!/bin/bash
#SBATCH --job-name=example1_job
#SBATCH --output=example1_job_%A_%a.out
#SBATCH --error=example1_job_%A_%a.err
#SBATCH --mail-user=richard.t.jones@uconn.edu
#SBATCH --mail-type=NONE
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=06:00:00
#SBATCH --partition=7452
#SBATCH --array=1-5

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
