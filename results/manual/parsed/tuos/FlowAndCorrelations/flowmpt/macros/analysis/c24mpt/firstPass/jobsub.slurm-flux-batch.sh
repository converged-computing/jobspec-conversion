#!/bin/bash
#FLUX: --job-name=joyous-lamp-0836
#FLUX: -t=244800
#FLUX: --urgency=16

export SCRAM_ARCH='slc7_amd64_gcc900'

echo $SLURM_JOB_ID
echo $SLURM_JOB_NAME
echo $SLURM_JOB_NODELIST
source /cvmfs/cms.cern.ch/cmsset_default.sh
export SCRAM_ARCH=slc7_amd64_gcc900
cd /scratch/tuos/i_ana2021/pbpb/miniAOD/CMSSW_11_2_2/src
eval `scramv1 runtime -sh`
cd /scratch/tuos/i_ana2021/pbpb/miniAOD/CMSSW_11_2_2/src/treeInput/oct22/c24/slurm/jb0
root -l covariance_2pc_and_meanpt.C
echo "Done!"
exit 0
