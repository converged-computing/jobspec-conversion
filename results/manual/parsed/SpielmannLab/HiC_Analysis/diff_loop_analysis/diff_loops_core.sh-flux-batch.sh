#!/bin/bash
#FLUX: --job-name=carnivorous-peanut-butter-0099
#FLUX: --queue=shortterm
#FLUX: --urgency=16

module load nextflow/v22.04.1
mkdir -p "$WORK"/diff_loops_nextflow_launchdir
rsync -r --update * "$WORK"/diff_loops_nextflow_launchdir/
cd "$WORK"/diff_loops_nextflow_launchdir
chmod +x bin/*
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
nextflow run diff_loops.nf -params-file diff_loops_params.yaml -resume
