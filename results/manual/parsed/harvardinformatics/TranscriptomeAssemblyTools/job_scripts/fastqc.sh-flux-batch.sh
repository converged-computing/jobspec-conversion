#!/bin/bash
#FLUX: --job-name=arid-buttface-2133
#FLUX: --priority=16

"""
For this script to initialize a conda environment, a version of python that supports
anaconda or mamba will need to be in PATH. In a case where the HPC environment has python
available as a loadable module, such as the Harvard Cannon cluster, 
it will simply require adding: module load python.
"""
source activate fastqc
infile=$1 # $1 represent the first (and in this case only) command line argument supplied to the script
echo "infile is $infile"
fastqc --outdir `pwd`/fastqc $infile
