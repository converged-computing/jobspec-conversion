#!/bin/bash
#FLUX: --job-name=blank-ricecake-4413
#FLUX: --priority=16

conda activate AMR++_env  # Explore the installation instructions on github to see how to install this environment
nextflow run main_AMR++.nf -profile local --threads 8 # This will use 8 threads, which corresponds with "--cpus-per-task=8". 
