#!/bin/bash
#FLUX: --job-name=pusheena-punk-6173
#FLUX: --urgency=16

snakemake --cores <num_cores> -s <snakefile_name>
