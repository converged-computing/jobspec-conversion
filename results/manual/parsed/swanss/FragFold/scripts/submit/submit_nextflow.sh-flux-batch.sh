#!/bin/bash
#FLUX: --job-name=nf-manager
#FLUX: --queue=xeon-p8
#FLUX: -t=360000
#FLUX: --priority=16

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
