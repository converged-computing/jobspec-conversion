#!/bin/bash
#FLUX: --job-name=wobbly-cupcake-4077
#FLUX: --priority=16

set -u
shopt -s globstar
num_jobs=$1
timestamp=$(date +%b_%d_%y_%H_%M_%e)
echo "using ${num_jobs} workers.."
parallel -j0 --timeout 600 --delay 2.5 --joblog prepare_chimera_pdbbind_2018_refined_docking_${timestamp}.out.test ./prepare_complexes_chimera.sh {} ::: find docking_parse_pipeline_test_run/**/*_pocket.pdb
echo "done."
