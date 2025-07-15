#!/bin/bash
#FLUX: --job-name="tara4IPS"
#FLUX: --queue=fat
#FLUX: --priority=16

conda deactivate
module load python/3.7.8
module load singularity/3.7.1 
./run_wf.sh -e ERR599171 -d TARA_OCEANS_SAMPLE -n ERR599171 -s -b
module purge
