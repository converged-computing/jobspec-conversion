#!/bin/bash
#FLUX: --job-name=peachy-pedo-0693
#FLUX: -t=86400
#FLUX: --urgency=16

set -e -x
FWDIR="$(cd "`dirname $0`"/..; pwd)"
BASEDIR=${BASEDIR:-${FWDIR}}
if [ "$#" -eq  "0" ]
  then
    echo "No arguments supplied"
    minRep=2
    maxOrder=4
    nTrees=1000
    mtry=100
    maxDepth=0
    minNode=5
    workingDir="/scratch2/IDENT/tst/tmp39_nTrees${nTrees}/"
else
    echo "Arguments suppliedd"
    minRep=$1
    maxOrder=$2
    nTrees=$3
    mtry=$4
    maxDepth=$5
    minNode=$6
    workingDir="/scratch2/IDENT/random_search/tmp311_nTrees${nTrees}_minRep${minRep}_maxOrder${maxOrder}_mtry${mtry}_maxDepth${maxDepth}_minNode${minNode}/"
fi
TASK_NUM="${SLURM_ARRAY_TASK_ID:-0}"
N_TASKS="${SLURM_ARRAY_TASK_COUNT:-0}"
TASK_TAG="$(printf '%04d' ${TASK_NUM})"
echo "Running batch task: ${TASK_NUM}  tag: $TASK_TAG"
mkdir -p "${workingDir}"
module load R/4.1.3
module load python/3.11.0
finalScript="python data_prep-parallel.py --split $TASK_NUM --nSplits $N_TASKS"
if [ -n "$minRep" ]; then
	finalScript+=" --minRep $minRep"
fi
if [ -n "$maxOrder" ]; then
        finalScript+=" --maxOrder $maxOrder"
fi
if [ -n "$nTrees" ]; then
        finalScript+=" --nTrees $nTrees"
fi
if [ -n "$mtry" ]; then
        finalScript+=" --mtry $mtry"
fi
if [ -n "$maxDepth" ]; then
        finalScript+=" --maxDepth $maxDepth"
fi
if [ -n "$minNode" ]; then
        finalScript+=" --minNode $minNode"
fi
if [ -n "$workingDir" ]; then
        finalScript+=" --workingDir $workingDir"
fi
echo $finalScript
eval $finalScript
