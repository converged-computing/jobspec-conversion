#!/bin/bash
#FLUX: --job-name=myMPI
#FLUX: -N=2
#FLUX: -n=2
#FLUX: --queue=development
#FLUX: -t=5400
#FLUX: --urgency=16

ibrun ./PipelineManager /work/02542/gteodoro/TCGA-02-0001-01Z-00-DX1.svs-tile/  -cpu 15 -gpu 1 -s priority -w 23
