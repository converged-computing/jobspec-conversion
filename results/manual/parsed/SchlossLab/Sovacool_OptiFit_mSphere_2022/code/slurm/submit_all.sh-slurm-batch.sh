#!/bin/bash
#FLUX: --job-name=OptiFit
#FLUX: --queue=standard
#FLUX: -t=345600
#FLUX: --urgency=16

source /etc/profile.d/http_proxy.sh  # required for internet on the Great Lakes cluster
for dir in $(2_fit_reference_db 3_fit_sample_split 4_vsearch); do
    pushd subworkflows/${dir}
    time snakemake --profile config/slurm --latency-wait 90
    popd
done
time snakemake --latency-wait 90
