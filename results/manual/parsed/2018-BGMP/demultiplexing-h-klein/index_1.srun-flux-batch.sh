#!/bin/bash
#FLUX: --job-name=hairy-signal-9782
#FLUX: --queue=short
#FLUX: -t=86400
#FLUX: --urgency=16

module load python3
module load racs-eb
module load matplotlib/2.1.1-intel-2017b-Python-3.6.3
python3 mean_per_base.py -f /projects/bgmp/shared/2017_sequencing/1294_S1_L008_R2_001.fastq.gz
