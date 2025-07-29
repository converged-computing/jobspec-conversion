#!/bin/bash
#FLUX: --job-name=simple
#FLUX: --queue=brown
#FLUX: -t=259200
#FLUX: --urgency=16

module load Python/3.7.4-GCCcore-8.3.0
module load CUDA/10.2.89-GCC-8.3.0
source venv/bin/activate
python src/cyclegan_with_monitoring.py
