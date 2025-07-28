#!/bin/bash
#FLUX: --job-name=nextflow
#FLUX: -c=2
#FLUX: --queue=cbcb
#FLUX: -t=1814400
#FLUX: --urgency=16

PROJDIR="/fs/nexus-projects/sc_read_census/nextflow"
cd $PROJDIR
$PROJDIR/nextflow $PROJDIR/main.nf -resume
