#!/bin/bash
#FLUX: --job-name=1_process_data
#FLUX: -c=256
#FLUX: --queue=parallel
#FLUX: -t=25200
#FLUX: --priority=16

module load GCC/11.3.0
module load OpenMPI/4.1.4
module load Python/3.10.4
source venv/bin/activate
echo "JOB STARTED"
date
echo -e "NB: Input files will appear out of order due to parallel processing. Output files will be in chronological order.\n"
mpirun --oversubscribe -n 256 python src/process_data.py
echo "FINISHED"
