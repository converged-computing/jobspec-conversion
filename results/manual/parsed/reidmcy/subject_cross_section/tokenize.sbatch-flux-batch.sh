#!/bin/bash
#FLUX: --job-name=tokenizer
#FLUX: -n=4
#FLUX: --queue=broadwl
#FLUX: -t=86400
#FLUX: --urgency=16

module load python/3.6.1+intel-16.0
module load java/1.8
module load libffi
source /project2/jevans/virt_sbatch/bin/activate
echo "Starting"
echo `which python`
python tokenizing.py
