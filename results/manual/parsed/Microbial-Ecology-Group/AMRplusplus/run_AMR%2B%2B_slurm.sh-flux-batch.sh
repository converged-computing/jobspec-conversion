#!/bin/bash
#FLUX: --job-name=chocolate-pancake-5860
#FLUX: -n=4
#FLUX: -c=8
#FLUX: --urgency=16

conda activate AMR++_env  # Explore the installation instructions on github to see how to install this environment
nextflow run main_AMR++.nf -profile local --threads 8 # This will use 8 threads, which corresponds with "--cpus-per-task=8". 
