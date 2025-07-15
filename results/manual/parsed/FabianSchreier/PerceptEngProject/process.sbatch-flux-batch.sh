#!/bin/bash
#FLUX: --job-name=PEP-P
#FLUX: -c=24
#FLUX: --queue=day
#FLUX: -t=86400
#FLUX: --priority=16

error=0
if [ -z "$1" ]
then
    dataset=Cat2000
    echo "Using dataset \"$dataset\": default"
else
    dataset=$1
    echo "Using config \"$dataset\": provided as \"$1\""
fi
mkdir /scratch/$SLURM_JOB_ID/Datasets
mkdir /scratch/$SLURM_JOB_ID/ProcessedDatasets
ls -al /scratch/$SLURM_JOB_ID/Datasets
echo Copying dataset
cp -a ~/Datasets/$dataset /scratch/$SLURM_JOB_ID/Datasets/$dataset
ls -al /scratch/$SLURM_JOB_ID/Datasets
echo Copying source code
cp -a ~/src/ /scratch/$SLURM_JOB_ID/src
echo Executing processing script
singularity exec ~/PerEng.1_15.simg python3 -u /scratch/$SLURM_JOB_ID/src/process.py \
        --dataset=$dataset \
        --dataset_root=/scratch/$SLURM_JOB_ID/Datasets \
        --output_root=/scratch/$SLURM_JOB_ID/ProcessedDatasets \
        --parallel_entries=50
echo Archiving process dataset
tar -zcf /scratch/$SLURM_JOB_ID/ProcessedDatasets/${dataset}.tar.gz -C /scratch/$SLURM_JOB_ID/ProcessedDatasets/ $dataset
ls -al /scratch/$SLURM_JOB_ID/ProcessedDatasets
echo Copying processed dataset ${dataset}.tar.gz to home ${dataset}_baseline.tar.gz
rm -R ~/ProcessedDatasets/${dataset}_baseline.tar.gz
cp -a /scratch/$SLURM_JOB_ID/ProcessedDatasets/${dataset}.tar.gz ~/ProcessedDatasets/${dataset}_baseline.tar.gz
echo Cleaning up job directory
rm -R /scratch/$SLURM_JOB_ID/Datasets
rm -R /scratch/$SLURM_JOB_ID/ProcessedDatasets
echo DONE!
