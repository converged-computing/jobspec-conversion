#!/bin/bash
#FLUX: --job-name=angry-itch-3934
#FLUX: --queue=shortterm
#FLUX: --priority=16

module load nextflow/v22.04.1
mkdir -p $WORK/hic_to_cool_nextflow_launchdir
rsync -rc * $WORK/hic_to_cool_nextflow_launchdir/
cd $WORK/hic_to_cool_nextflow_launchdir
rm slurm*.out
if [[ $1 = -resume ]]; then
    echo "Resuming the previous nextflow run"
else
    echo "Cleaning up all the previous nextflow runs"
    echo "If you wanted to resume the previous run, use the '-resume' option"
    while [[ $(nextflow log | wc -l) -gt 1 ]]; do
        nextflow clean -f
    done
fi
nextflow run hic_to_cool.nf -params-file hic_to_cool_params.yaml -resume
