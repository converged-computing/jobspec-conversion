#!/bin/bash
#FLUX: --job-name=mqc
#FLUX: --queue=phillips
#FLUX: -t=14400
#FLUX: --urgency=16

module load easybuild  icc/2017.1.132-GCC-6.3.0-2.27  impi/2017.1.132 MultiQC/1.3-Python-3.6.1
cd fastqc_raw
multiqc .
