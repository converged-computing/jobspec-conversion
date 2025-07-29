#!/bin/bash
#SBATCH --account=project_2001659
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=20
#SBATCH --mem=10G
#SBATCH --time=00:10:10

module load maestro parallel
find data  -name '*.sdf' | \
parallel -j $SLURM_CPUS_PER_TASK bash ${SLURM_SUBMIT_DIR}/wrapper.sh {}
2.sd -LOCAL -NOJOBID"
