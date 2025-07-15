#!/bin/bash
#FLUX: --job-name="ppjb0"
#FLUX: -t=72000
#FLUX: --priority=16

export SCRAM_ARCH='slc6_amd64_gcc491'
export X509_USER_PROXY='/home/tuos/x509up_u126986'

source /cvmfs/cms.cern.ch/cmsset_default.sh
export SCRAM_ARCH=slc6_amd64_gcc491
export X509_USER_PROXY=/home/tuos/x509up_u126986
cd /scratch/tuos/temp/cmssw/CMSSW_7_5_0/src/ppreco/jobs/pp/redo/run/v2_50evts/jb0
eval `scramv1 runtime -sh`
cmsRun step2_RAW2DIGI_L1Reco_ppRECO.py
exit 0
