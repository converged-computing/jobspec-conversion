#!/bin/bash
#FLUX: --job-name=examplejob
#FLUX: --queue=standard-g
#FLUX: -t=7200
#FLUX: --urgency=16

module load LUMI/22.08
module load cotainr
cotainr build lumi_env_container_test.sif --base-image=docker://rocm/dev-ubuntu-22.04:5.3.2-complete --conda-env=lumi_env.yml
