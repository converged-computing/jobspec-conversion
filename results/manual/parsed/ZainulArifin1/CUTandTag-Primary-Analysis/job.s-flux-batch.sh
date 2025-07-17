#!/bin/bash
#FLUX: --job-name=CUT&Tag Pipeline
#FLUX: --urgency=16

snakemake --cores <num_cores> -s <snakefile_name>
