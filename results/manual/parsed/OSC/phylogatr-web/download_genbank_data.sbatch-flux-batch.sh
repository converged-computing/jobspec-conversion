#!/bin/bash
#FLUX: --job-name=genbank_update
#FLUX: --urgency=16

module purge
set -x
cd $SLURM_SUBMIT_DIR
[ -f "$SLURM_SUBMIT_DIR/env" ] && source "$SLURM_SUBMIT_DIR/env"
set +x
module load ruby/$PHYLOGATR_RUBY_VERSION
mkdir -p "$PHYLOGATR_GENBANK_DIR"
bin/bundle exec bin/db download_genbank $PHYLOGATR_GENBANK_DIR
