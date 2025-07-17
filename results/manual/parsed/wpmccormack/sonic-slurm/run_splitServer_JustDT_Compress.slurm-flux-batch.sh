#!/bin/bash
#FLUX: --job-name=run_splitServer_JustDT_Compress
#FLUX: -c=4
#FLUX: --exclusive
#FLUX: -t=18000
#FLUX: --urgency=16

export SCRAM_ARCH='slc7_amd64_gcc900'

hostname
echo $1
echo $2
mkdir /tmp/dir_${SLURM_JOB_ID}_${SLURM_PROCID}
cd /tmp/dir_${SLURM_JOB_ID}_${SLURM_PROCID}
pwd
current_epoch=$(date +%s)
echo $current_epoch
target_epoch=$(date -d "$3" +%s)
echo $target_epoch
sleep_seconds=$(( $target_epoch - $current_epoch ))
echo $sleep_seconds
sleep $sleep_seconds
export SCRAM_ARCH=slc7_amd64_gcc900
source /cvmfs/cms.cern.ch/cmsset_default.sh
CMS_PATH=~/cms_path
ll $CMS_PATH/SITECONF/local/JobConfig/site-local-config.xml
scram p CMSSW_11_3_0
cd CMSSW_11_3_0
eval `scramv1 runtime -sh`
cd ../
mkdir test_REAL
cd test_REAL
pwd
cp ~/CMSSW_12_0_0_pre5_ttbar_DT_Compress.tgz .
tar -xf CMSSW_12_0_0_pre5_ttbar_DT_Compress.tgz
cd CMSSW_12_0_0_pre5/src/sonic-workflows
cp ~/allSonicTriton_cff_JustDT.py ../Configuration/ProcessModifiers/python/allSonicTriton_cff.py
scramv1 b -r ProjectRename # this handles linking the already compiled code - do NOT recompile
eval `scramv1 runtime -sh`
ln -s /home/wmccorma_mit_edu/local_files/*.root .
cp ~/file_of_files.txt .
cp ~/run_files_splitServer.py .
cmsRun run_files_splitServer.py address=$1 port=$2 tmi=True threads=4 maxEvents=8
current_epoch2=$(date +%s)
echo $current_epoch2
target_epoch2=$(date -d "$3" +%s)
extrasecs=600
target_epoch2=$(( $target_epoch2 + $extrasecs ))
echo $target_epoch2
sleep_seconds2=$(( $target_epoch2 - $current_epoch2 ))
echo $sleep_seconds2
sleep $sleep_seconds2
cmsRun run_files_splitServer.py address=$1 port=$2 tmi=True  threads=4 maxEvents=1000 &> outThroughput.txt
python3.6 ~/throughputFinderTimeDiff.py outThroughput.txt ~/splitServer_JustDT_Compress_arrays/Synchro${SLURM_ARRAY_JOB_ID}.txt
cd /tmp
cd /tmp
rm -rf dir_${SLURM_JOB_ID}_${SLURM_PROCID}
