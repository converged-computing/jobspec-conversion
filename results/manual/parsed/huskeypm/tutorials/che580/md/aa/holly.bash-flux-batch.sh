#!/bin/bash
#FLUX: --job-name=red-peas-5187
#FLUX: -t=108000
#FLUX: --priority=16

export EXEC='charmrun ++p $NP ++mpiexec /share/apps/NAMD/2.9/Linux-x86_64-ibverbs/namd2'

module load NAMD
NP=$SLURM_NTASKS
echo "Running with $NP tasks" 
export EXEC="charmrun ++p $NP ++mpiexec /share/apps/NAMD/2.9/Linux-x86_64-ibverbs/namd2"
            #charmrun ++p   2 ++mpiexec /share/apps/NAMD/2.9/Linux-x86_64-ibverbs/namd2 production_iter30.conf
${EXEC} run.conf >& run.out 
