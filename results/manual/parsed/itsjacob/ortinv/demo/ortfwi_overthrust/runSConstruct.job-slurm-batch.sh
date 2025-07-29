#!/bin/bash
#FLUX: --job-name=run
#FLUX: -N=24
#FLUX: --exclusive
#FLUX: --queue=compute
#FLUX: --urgency=16

export LOCALDATAPATH='/localscratch'

cd $SLURM_SUBMIT_DIR
export LOCALDATAPATH=/localscratch
rm -rf /local/tmpswfl
scons -f SConstruct
rm -rf /local/tmpswfl
