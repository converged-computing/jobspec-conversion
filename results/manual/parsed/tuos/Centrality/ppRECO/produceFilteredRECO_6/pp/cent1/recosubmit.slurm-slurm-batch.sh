#!/bin/bash
#SBATCH --job-name=ppReco
#SBATCH --output=job01.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=4G
#SBATCH --time=2-20:00:00

export SCRAM_ARCH='slc6_amd64_gcc491'
export X509_USER_PROXY='/home/tuos/x509up_u126986'

source /cvmfs/cms.cern.ch/cmsset_default.sh
export SCRAM_ARCH=slc6_amd64_gcc491
export X509_USER_PROXY=/home/tuos/x509up_u126986
cd /scratch/tuos/temp/cmssw/CMSSW_7_5_0/src/ppreco/jobs/pp/redo/run/v3_50reco/cent1
eval `scramv1 runtime -sh`
cmsRun step2_RAW2DIGI_L1Reco_ppRECO.py
exit 0
