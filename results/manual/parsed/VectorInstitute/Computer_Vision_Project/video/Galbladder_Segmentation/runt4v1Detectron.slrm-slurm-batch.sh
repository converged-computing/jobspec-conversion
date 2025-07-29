#!/bin/bash
#SBATCH --job-name=abc123
#SBATCH --output=./%j_testJob.out
#SBATCH --error=./%j_testJob.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --gres=gpu:1
#SBATCH --mem=8G
#SBATCH --qos=normal

if [ -z "$SLURM_JOB_ID" ]
then
    echo ------------- FAILED ----------------
    echo \$SLURM_JOB_ID is empty, did you launch the script with "sbatch" ?
    exit
else
    echo Job $SLRUM_JOB_ID is running
fi
module load vector_cv_project
hostname
which python
nvidia-smi
echo "This goes to stderr" 1>&2
wd=0.0001
ims=8
lr=0.00001
e=30
roi=512
touch $SLURM_JOB_ID'_'$wd'_'$ims'_'$lr'_'$e'_.txt'
python DetectronGBScript.py --wd $wd --ims $ims --lr $lr --e $e --roi $roi --d 'detectron2/output/'$wd'_'$ims'_'$lr'_'$e'/'
