#!/bin/bash
#FLUX: --job-name=nf-manager
#FLUX: --queue=xeon-p8
#FLUX: -t=360000
#FLUX: --urgency=16

ENV=fragfold3
WORKFLOW=/data1/groups/keatinglab/swans/savinovCollaboration/FragFold/nextflow/process_v1_output.nf
NF_CFG=/data1/groups/keatinglab/swans/savinovCollaboration/FragFold/nextflow/nextflow.config
WORK_DIR=$(pwd -P)
USER=$(whoami) && cd $TMPDIR
echo "tmpdir: "$TMPDIR
if [ -d "$LOGS" ]; then
    cp -r $LOGS/.nextflow .
    cp $LOGS/.nextflow.log* .
else
    mkdir -p ${WORK_DIR}/nextflow_logs
fi
conda run -n $ENV --no-capture-output nextflow run $WORKFLOW -w $WORK_DIR -c $NF_CFG -resume 
cp -r .nextflow* ${WORK_DIR}/nextflow_logs && \
    cp *.csv $WORK_DIR && \
    echo 'Finished job and copied files from $TMPDIR'
