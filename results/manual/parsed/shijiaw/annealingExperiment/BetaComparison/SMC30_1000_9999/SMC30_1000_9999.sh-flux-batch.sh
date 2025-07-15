#!/bin/bash
#FLUX: --job-name=evasive-kitty-2724
#FLUX: --priority=16

module load r/3.4.0
module load java/1.8.0_121
nextflow run  SMC30_1000_9999.nf -resume
