#!/bin/bash
#FLUX: --job-name=mp_isolet-gb0
#FLUX: -c=4
#FLUX: --queue=standard
#FLUX: -t=600
#FLUX: --priority=16

n_procs=4
module load tensorflow
cat run-mp_isolet.sh
date
cd /home/jbhender/github/Stats507_F21/demo/
python mp_isolet.py $n_procs
date
echo "Done."
