#!/bin/bash
#FLUX: --job-name=red-buttface-0974
#FLUX: --priority=16

export NXF_TEMP='/scratch'
export NXF_LAUNCHBASE='/scratch'
export NXF_WORK='/scratch'
export NXF_HOME='/castor/project/proj_nobackup/nextflow'
export PATH='${NXF_HOME}/bin:${PATH}'

set -xeuo pipefail
GENOME=GRCh38
SAMPLE=''
STEP=''
TOOLS=false
while [[ $# -gt 0 ]]
do
  key=$1
  case $key in
    -g|--genome)
    GENOME=$2
    shift # past argument
    shift # past value
    ;;
    -s|--sample)
    SAMPLE=$2
    shift # past argument
    shift # past value
    ;;
    --step)
    STEP=$2
    shift # past argument
    shift # past value
    ;;
    -t|--tools)
    TOOLS=$2
    shift # past argument
    shift # past value
    ;;
    *) # unknown option
    shift # past argument
    ;;
  esac
done
DATE=`date +%Y-%b-%d-%H%M`
if [[ $TOOLS ]]
then
  PREFIX=${TOOLS}_${DATE}
else
  PREFIX=${DATE}
fi
CAW=/castor/project/proj_nobackup/CAW/default
ln -fs /castor/project/proj_nobackup/CAW/containers containers
export NXF_TEMP=/scratch
export NXF_LAUNCHBASE=/scratch
export NXF_WORK=/scratch
export NXF_HOME=/castor/project/proj_nobackup/nextflow
export PATH=${NXF_HOME}/bin:${PATH}
function run_caw() {
  nextflow run ${CAW}/main.nf $@ -with-timeline ${PREFIX}.timeline.html -with-trace ${PREFIX}.trace.txt
}
if [[ $STEP == MAPPING ]]
then
  run_caw() --sample ${SAMPLE} --step mapping
fi
if [[ $STEP == VARIANTCALLING ]]
then
  run_caw() --sample ${SAMPLE} --step variantcalling --tools ${TOOLS}
fi
if [[ $STEP == ANNOTATE ]]
then
  run_caw() --step annotate --tools ${TOOLS} --annotateVCF ${SAMPLE}
fi
