#!/bin/bash
#FLUX: --job-name=strawberry-parsnip-1018
#FLUX: --urgency=16

echo "SCRATCH_DIR: $SCRATCH_DIR"
BATCHSIZE=2000
SIMNAME="vb-cb-psens-bs${BATCHSIZE}"
AWS_BUCKET="s3://cytof-vb/${SIMNAME}"
RESULTS_DIR="results/${SIMNAME}"
module load R/R-3.6.1
julia -e 'import Pkg; Pkg.activate(joinpath(@__DIR__, "../../")); Pkg.build("RCall")'
echo "This is a healthy sign of life ..."
echo "This node has `nproc` processors."
mkdir -p $RESULTS_DIR
NUM_PROCS=40
julia run.jl $NUM_PROCS $BATCHSIZE $RESULTS_DIR &> $RESULTS_DIR/log.txt &
echo "Job submission time:"
date
echo "Jobs are now running. A message will be printed and emailed when jobs are done."
wait
echo "Jobs are completed."
aws s3 sync $RESULTS_DIR $AWS_BUCKET --exclude '*.nfs'
echo "Job completion time:"
date
