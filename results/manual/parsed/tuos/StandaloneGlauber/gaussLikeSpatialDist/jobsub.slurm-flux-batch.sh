#!/bin/bash
#FLUX: --job-name=ornery-leader-9412
#FLUX: -t=162000
#FLUX: --priority=16

export SCRAM_ARCH='slc6_amd64_gcc700'

echo $SLURM_JOB_ID
echo $SLURM_JOB_NAME
echo $SLURM_JOB_NODELIST
source /cvmfs/cms.cern.ch/cmsset_default.sh
export SCRAM_ARCH=slc6_amd64_gcc700
cd /scratch/tuos/glauber/CMSSW_10_3_0/src
eval `scramv1 runtime -sh`
cd /scratch/tuos/glauber/CMSSW_10_3_0/src/v3p2/standalone/StandaloneGlauber/slurm
root -l -b <<EOF
.L runglauber_v1.5.C+
runAndSaveNtuple(100000,"Pb","Pb",61.8,0.4,"glauber_PbPb_default_v1p5_100k.root")
EOF
echo "Done!"
exit 0
