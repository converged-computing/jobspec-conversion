#!/bin/bash
#FLUX: --job-name=corona_optimize
#FLUX: -t=345600
#FLUX: --urgency=16

set -ex
snakemake -j 100 --cluster ' mysbatch -p rbaltman --mem 4G --gpus {params.gpucount} --time 4:00:00' --latency-wait 60 --nolock -p
