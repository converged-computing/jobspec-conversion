#!/bin/bash
#FLUX: --job-name=CAMP
#FLUX: -c=128
#FLUX: --queue=standard
#FLUX: -t=300
#FLUX: --urgency=16

export OMP_NUM_THREADS='128'
export OMP_PROC_BIND='true'

export OMP_NUM_THREADS=128
export OMP_PROC_BIND=true
srun --hint=nomultithread --unbuffered build/camp -s 1024000000 -r 3 -t 8,16,32,64,128 -i 0.02,0.04,0.08,0.1,0.16,0.32,0.64,1.28,2.56 -f result_hardcode.csv -k contig
module load cray-python
source /work/ta094/ta094/wenqingpeng/pyenv-camp/bin/activate
python ../scripts/mesh.py result_hardcode.csv
