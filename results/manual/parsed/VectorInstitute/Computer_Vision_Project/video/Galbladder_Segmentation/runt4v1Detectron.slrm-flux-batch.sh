#!/bin/bash
#FLUX: --job-name=abc123
#FLUX: -c=2
#FLUX: --queue=t4v1
#FLUX: --priority=16

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
