#!/bin/bash
#FLUX: --job-name=AOD_ALL
#FLUX: -t=244800
#FLUX: --urgency=16

export SCRAM_ARCH='slc6_amd64_gcc491'

source /cvmfs/cms.cern.ch/cmsset_default.sh
export SCRAM_ARCH=slc6_amd64_gcc491
cd /scratch/tuos/reco2AOD/CMSSW_7_5_0_pre5/src/timingSpace/v1
eval `scramv1 runtime -sh`
cmsRun step2_RAW2DIGI_L1Reco_MB_AODSIM2760GeV.py
cmsRun step2_RAW2DIGI_L1Reco_MB_AODSIM5020GeV.py
cmsRun step2_RAW2DIGI_L1Reco_DIJET_AODSIM2760GeV.py
cmsRun step2_RAW2DIGI_L1Reco_DIJET_AODSIM5020GeV.py
cmsRun step2_RAW2DIGI_L1Reco_MB_AOD.py
cmsRun step2_RAW2DIGI_L1Reco_JET_AOD.py
cmsRun step2_RAW2DIGI_L1Reco_DIMUONskim_AOD.py
cmsRun step2_RAW2DIGI_L1Reco_UCC_AOD.py
exit 0
