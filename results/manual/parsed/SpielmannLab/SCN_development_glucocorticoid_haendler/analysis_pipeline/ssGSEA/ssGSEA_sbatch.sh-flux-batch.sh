#!/bin/bash
#FLUX: --job-name=blank-latke-3961
#FLUX: --queue=shortterm
#FLUX: --priority=16

PATH=$WORK/.omics/anaconda3/bin:$PATH #add the anaconda installation path to the bash path
source $WORK/.omics/anaconda3/etc/profile.d/conda.sh # some reason conda commands are not added by default
mkdir -p "$WORK/ssGSEA_nextflow_launchdir"
rsync -r --update * "$WORK/ssGSEA_nextflow_launchdir/"
cd "$WORK/ssGSEA_nextflow_launchdir"
chmod +x bin/*
rm slurm*
module load nextflow/v22.04.1
if [[ $1 = -resume ]]; then
    echo "Resuming the previous nextflow run"
else
    echo "Cleaning up all the previous nextflow runs"
    echo "If you wanted to resume the previous run, use the '-resume' option"
    while [[ $(nextflow log | wc -l) -gt 1 ]]; do
        nextflow clean -f
    done
fi
nextflow run ssGSEA.nf -params-file ssGSEA_params.yaml -profile omics -resume
