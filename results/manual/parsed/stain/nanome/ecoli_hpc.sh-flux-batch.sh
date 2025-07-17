#!/bin/bash
#FLUX: --job-name=nanome.ecoli_demo_hpc
#FLUX: -n=4
#FLUX: --queue=inference
#FLUX: -t=7200
#FLUX: --urgency=16

set -e
date; hostname; pwd
baseDir=${1:-/fastscratch/$USER/nanome}
pipelineName=${2:-"ecoli_demo"}
rm -rf ${baseDir}/${pipelineName}
mkdir -p ${baseDir}/${pipelineName}
module load singularity
set -x
cd ${baseDir}/${pipelineName}
nextflow run ${NANOME_DIR}\
    -resume -with-report -with-timeline -with-trace -with-dag\
    -profile singularity,hpc\
    --dsname EcoliDemo\
    -config ${NANOME_DIR}/conf/executors/jaxhpc_input.config,${NANOME_DIR}/conf/examples/ecoli_demo.config\
    --runDeepMod --runTombo --runMETEORE\
    --outputIntermediate --outputRaw\
    --outputGenomeBrowser --outputBam --outputONTCoverage\
    --deduplicate --sort\
    --processors 8
tree work >  ${pipelineName}_work_filetree.txt
tree results >  ${pipelineName}_results_filetree.txt
tar -czf ${pipelineName}.tar.gz  \
    ${pipelineName}_results_filetree.txt ${pipelineName}_work_filetree.txt \
    work/*/*/.command.* work/*/*/*.run.log \
    *trace/  .nextflow.log
find  work  -name '*.Report.run.log' -exec tail {} \;
echo "### NANOME pipeline for ecoli_demo on HPC DONE"
