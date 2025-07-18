#!/bin/bash
#FLUX: --job-name=call_tad
#FLUX: --queue=shortterm
#FLUX: --urgency=16

module load nextflow/v22.04.1
mkdir -p "${WORK}/call_tad_nextflow_launchdir"
rsync -r --update * "${WORK}/call_tad_nextflow_launchdir"
cd "${WORK}/call_tad_nextflow_launchdir"
rm slurm*.out
if [[ $1 = -resume ]]; then
    echo "Resuming the previous nextflow run"
else
    echo "Cleaning up all the previous nextflow runs"
    echo "If you wanted to resume the previous run, use the '-resume' option when calling sbatch"
    while [[ $(nextflow log | wc -l) -gt 1 ]]; do
        nextflow clean -f
    done
fi
nextflow run call_tad_main.nf -params-file call_tad_params.yaml -resume
