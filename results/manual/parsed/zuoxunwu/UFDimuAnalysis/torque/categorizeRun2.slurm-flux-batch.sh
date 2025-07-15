#!/bin/bash
#FLUX: --job-name=categorizeRun2
#FLUX: -t=36000
#FLUX: --priority=16

export SCRAM_ARCH='slc6_amd64_gcc491'
export CMS_PATH='/cvmfs/cms.cern.ch'
export CVSROOT=':pserver:anonymous@cmssw.cvs.cern.ch:/local/reps/CMSSW'

export SCRAM_ARCH=slc6_amd64_gcc491
export CMS_PATH=/cvmfs/cms.cern.ch
source ${CMS_PATH}/cmsset_default.sh
export CVSROOT=:pserver:anonymous@cmssw.cvs.cern.ch:/local/reps/CMSSW
cd /home/puno/cmsswinit/CMSSW_7_5_8/src/
eval `scram runtime -sh`
cd /home/puno/h2mumu/UFDimuAnalysis_v2/bin/
date
hostname
pwd
echo "JOB ID: ${SLURM_ARRAY_JOB_ID}"
echo "ARRAY ID: ${SLURM_ARRAY_TASK_ID}"
echo ""
./categorizeRun2 ${SLURM_ARRAY_TASK_ID} 0 0 1 0
date
