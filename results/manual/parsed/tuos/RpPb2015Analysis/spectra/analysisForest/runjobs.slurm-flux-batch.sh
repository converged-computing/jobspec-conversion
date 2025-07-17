#!/bin/bash
#FLUX: --job-name=psycho-bits-0399
#FLUX: -t=244800
#FLUX: --urgency=16

export SCRAM_ARCH='slc6_amd64_gcc491'

echo $SLURM_JOB_ID
echo $SLURM_JOB_NAME
echo $SLURM_JOB_NODELIST
source /cvmfs/cms.cern.ch/cmsset_default.sh
export SCRAM_ARCH=slc6_amd64_gcc491
cd /home/tuos/forest/feb02/CMSSW_7_5_8/src
eval `scramv1 runtime -sh`
cd /home/tuos/forest/feb02/CMSSW_7_5_8/src/HeavyIonsAnalysis/JetAnalysis/test/crab/mc/pu1/ana/pu1nVz1VZD
root -l -b loopFiles.C
echo "Done!"
exit 0
