#!/bin/bash
#FLUX: --job-name=MAGs_SRR7877884
#FLUX: -c=62
#FLUX: -t=172800
#FLUX: --priority=16

export OMP_NUM_THREADS='8'
export OMP_PLACES='threads'
export OMP_PROC_BIND='spread'

export OMP_NUM_THREADS=8
export OMP_PLACES=threads
export OMP_PROC_BIND=spread
cd /global/cfs/projectdirs/m3408/aim2/metagenome/MAGs
java -XX:ParallelGCThreads=62 -Dconfig.file=shifter.conf -jar /global/common/software/m3408/cromwell-45.jar run -i input_SRR7877884.json  MAGgeneration_docker.wdl
