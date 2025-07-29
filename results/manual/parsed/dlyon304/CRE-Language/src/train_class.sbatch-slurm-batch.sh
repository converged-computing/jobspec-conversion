#!/bin/bash
#SBATCH --job-name=cnn_class
#SBATCH --output=log/class_cnn.out-%A_%a
#SBATCH --error=log/class_cnn.out-%A_%a
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu
#SBATCH --mem=8G
#SBATCH --array=1-10%3

eval $(spack env activate --sh tensorflow)
if [ -z ${SLURM_ARRAY_TASK_ID} ] ; then
    fold=1
    runname=${SLURM_JOB_ID}
else
    fold=${SLURM_ARRAY_TASK_ID}
    runname=${SLURM_ARRAY_JOB_ID}
fi
script=src/train_class.py
dirname=Runs/$1/${fold}
mkdir -p $dirname
cp $script Runs/$1/
datafile=Data/ATAC/ATAC.csv
python3 src/train_class.py $dirname $datafile --num_classes 2 --fold ${fold} --FEATURE_KEY sequence --LABEL_KEY open
