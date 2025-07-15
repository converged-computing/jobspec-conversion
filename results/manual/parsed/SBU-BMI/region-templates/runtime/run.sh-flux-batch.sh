#!/bin/bash
#FLUX: --job-name=expensive-pancake-5932
#FLUX: --priority=16

ibrun ./PipelineManager /work/02542/gteodoro/TCGA-02-0001-01Z-00-DX1.svs-tile/  -cpu 15 -gpu 1 -s priority -w 23
