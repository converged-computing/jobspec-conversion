#!/bin/bash
#FLUX: --job-name=FV3_container
#FLUX: -N=2
#FLUX: -n=4
#FLUX: -t=900
#FLUX: --urgency=16

dirRoot=/contrib/fv3
intelVersion=2022.1.1
container=/contrib/containers/HPC-ME_base-ubuntu20.04-intel${intelVersion}.sif 
if [ -z "$1" ]
  then
    echo "No branch supplied; using main"
    branch=main
  else
    echo Branch is ${1}
    branch=${1}
fi
testRoot=${dirRoot}/${intelVersion}/${branch}
buildDir=${testRoot}/build
srcDir=${testRoot}/src
logDir=${testRoot}/log
rm -rf ${testDir}
mkdir -p ${buildDir}
mkdir -p ${logDir}
mkdir -p ${srcDir}
sudo yum install -y singularity
cd ${srcDir}
cd ${buildDir}
set -o pipefail
singularity exec -B /lustre,/contrib ${container} hostname |& tee ${logDir}/compile.log # INSERT BUILD SCRIPT FOR hostname ;  PIPE OUTPUT TO ${logDir}/compile.log
set -o pipefail
singularity exec -B /lustre,/contrib ${container} hostname |& tee ${logDir}/run.log # INSERT RUN SCRIPT FOR hostname ; PIPE OUTPUT TO ${logDir}/run.log
