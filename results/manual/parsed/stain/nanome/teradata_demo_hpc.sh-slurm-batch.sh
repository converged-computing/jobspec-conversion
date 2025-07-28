#!/bin/bash
#FLUX: --job-name=nanome.teradata_hpc
#FLUX: -n=12
#FLUX: --queue=training
#FLUX: -t=1209600
#FLUX: --urgency=16

set -e
date; hostname; pwd
chrName=${1:-"chr22"}
baseDir=${2:-"/fastscratch/$USER/nanome"}
pipelineDir=${baseDir}/na12878_${chrName}_test
rm -rf $pipelineDir
mkdir -p $pipelineDir
cd $pipelineDir
module load singularity
echo "### Start test on teradata ${chrName}"
set -x
nextflow run ${NANOME_DIR}\
        -resume -with-report -with-timeline -with-trace -with-dag\
        -profile singularity,hpc \
        -config ${NANOME_DIR}/conf/executors/jaxhpc_input.config,${NANOME_DIR}/conf/executors/na12878_hpc.config\
        --dsname NA12878_${chrName^^} \
        --input "https://raw.githubusercontent.com/TheJacksonLaboratory/nanome/master/inputs/na12878_${chrName}.filelist.txt"
echo "### Run pass on teradata ${chrName} for NANOME"
