#!/bin/bash
#FLUX: --job-name=jobname
#FLUX: --urgency=16

module purge all
module load namd
/software/NAMD/2.13/verbs/charmrun /software/NAMD/2.13/verbs/namd2 +p$SLURM_NPROCS run.namd > run_namd.log
