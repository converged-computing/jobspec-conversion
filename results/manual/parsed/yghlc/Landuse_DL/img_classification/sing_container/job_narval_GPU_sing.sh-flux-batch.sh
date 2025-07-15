#!/bin/bash
#FLUX: --job-name=testGPU
#FLUX: -n=4
#FLUX: -t=3600
#FLUX: --priority=16

module purge
module load StdEnv/2020 apptainer/1.1.8
echo "== This is the scripting step! =="
./runIN_sing.sh
echo "== End of Job =="
