#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/webvalley2013/Hadoop-Phenoripper/phenoripper/bin/PhenoRipper_mcr/toolbox/distcomp/bin/util/pbs/pbsParallelWrapper.sh
