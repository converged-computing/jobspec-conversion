#!/bin/bash
#SBATCH --job-name=jobname
#SBATCH --account=p31412
#SBATCH --output=R-%x.%j.out
#SBATCH --error=R-%x.%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=7-00:00:00
#SBATCH --constraint=ntasks-per-node=64

module purge all
module load namd
/software/NAMD/2.13/verbs/charmrun /software/NAMD/2.13/verbs/namd2 +p$SLURM_NPROCS run.namd > run_namd.log
