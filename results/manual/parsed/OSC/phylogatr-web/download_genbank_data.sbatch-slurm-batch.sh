#!/bin/bash
#SBATCH --job-name=genbank_update
#SBATCH --output=log/%x-%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=3-00:00:00

module purge
set -x
cd $SLURM_SUBMIT_DIR
[ -f "$SLURM_SUBMIT_DIR/env" ] && source "$SLURM_SUBMIT_DIR/env"
set +x
module load ruby/$PHYLOGATR_RUBY_VERSION
mkdir -p "$PHYLOGATR_GENBANK_DIR"
bin/bundle exec bin/db download_genbank $PHYLOGATR_GENBANK_DIR
