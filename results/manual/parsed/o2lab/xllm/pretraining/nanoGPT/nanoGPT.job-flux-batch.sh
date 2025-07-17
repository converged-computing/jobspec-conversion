#!/bin/bash
#FLUX: --job-name=nanoGPT
#FLUX: -N=2
#FLUX: -c=32
#FLUX: -t=21600
#FLUX: --urgency=16

cd $SCRATCH
module add GCC/10.3.0  OpenMPI/4.1.1
module load WebProxy
/bin/bash
source activate llm
cd /scratch/user/siweicui/
python /scratch/user/siweicui/override_script.py
cd /scratch/user/siweicui/nanoGPT/
bash run_master.sh
