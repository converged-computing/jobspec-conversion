#!/bin/bash
#SBATCH --job-name=nf-manager
#SBATCH --output=nf-fragfold.%j.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=1G
#SBATCH --time=4-04:00:00
#SBATCH --partition=xeon-p8

ENV=fragfold
WORKFLOW=/data1/groups/keatinglab/swans/savinovCollaboration/FragFold/nextflow/ftsZ_homomeric_example.nf
NF_CFG=/data1/groups/keatinglab/swans/savinovCollaboration/FragFold/nextflow/nextflow.config
WORK_DIR=$(pwd -P)
mkdir -p ${WORK_DIR}
mkdir -p ${WORK_DIR}/nextflow_logs
USER=$(whoami) && cd $TMPDIR
conda run -n $ENV --no-capture-output nextflow run $WORKFLOW -w $WORK_DIR -c $NF_CFG -resume 
cp *.csv $WORK_DIR && \
    cp -r .nextflow* ${WORK_DIR}/nextflow_logs && \
    echo 'Finished job and copied files from $TMPDIR'
