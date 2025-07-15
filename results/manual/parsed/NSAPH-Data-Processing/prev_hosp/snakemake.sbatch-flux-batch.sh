#!/bin/bash
#FLUX: --job-name=conspicuous-caramel-5599
#FLUX: --priority=16

date #print start time
snakemake --cores 6
date #print end time
