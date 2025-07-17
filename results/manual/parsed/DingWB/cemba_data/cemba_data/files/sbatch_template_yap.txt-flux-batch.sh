#!/bin/bash
#FLUX: --job-name={job_name}
#FLUX: --queue={queue}
#FLUX: --urgency=16

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
{command}
