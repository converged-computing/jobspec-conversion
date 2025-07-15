#!/bin/bash
#FLUX: --job-name=strawberry-earthworm-5322
#FLUX: -t=108000
#FLUX: --priority=16

export EXEC='charmrun ++p $NP ++mpiexec /share/apps/NAMD/2.9/Linux-x86_64-ibverbs/namd2'

module load NAMD
NP=$SLURM_NTASKS
echo "Running with $NP tasks" 
export EXEC="charmrun ++p $NP ++mpiexec /share/apps/NAMD/2.9/Linux-x86_64-ibverbs/namd2"
            #charmrun ++p   2 ++mpiexec /share/apps/NAMD/2.9/Linux-x86_64-ibverbs/namd2 production_iter30.conf
${EXEC} Minimization.conf >& Minimization.out 
${EXEC} Annealing.conf >& Annealing.out 
${EXEC} Equilibration.conf >& Equilibration.out 
${EXEC} MD.conf >& MD.out 
