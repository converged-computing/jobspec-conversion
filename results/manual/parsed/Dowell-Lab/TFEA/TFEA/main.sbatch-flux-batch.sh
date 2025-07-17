#!/bin/bash
#FLUX: --job-name=TFEA
#FLUX: -n=10
#FLUX: --queue=short
#FLUX: -t=86400
#FLUX: --urgency=16

module purge
module load python/3.6.3
module load R/3.6.1
module load bedtools/2.25.0
module load meme/5.0.3
module load samtools/1.3.1
module load gcc/7.1.0
if [[ ${venv} != . ]]; then
    source ${venv}/bin/activate
fi
python3 ${cmd}
