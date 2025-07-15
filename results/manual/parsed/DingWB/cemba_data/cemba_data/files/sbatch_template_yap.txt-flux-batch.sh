#!/bin/bash
#FLUX: --job-name=crunchy-muffin-0652
#FLUX: --priority=16

export OMP_NUM_THREADS='48'

{email_str}
{email_type_str}
which python
which snakemake
which yap
which allcools
which bismark
date
hostname
pwd
export OMP_NUM_THREADS=48
{command}
