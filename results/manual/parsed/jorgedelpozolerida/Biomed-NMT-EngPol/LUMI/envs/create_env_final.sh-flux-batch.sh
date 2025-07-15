#!/bin/bash
#FLUX: --job-name=create_env
#FLUX: --queue=standard-g
#FLUX: -t=72000
#FLUX: --urgency=16

module load LUMI/22.08
module load cotainr
cotainr build final_container.sif  --base-image=docker://rocm/dev-ubuntu-22.04:5.3.2-complete --conda-env=final-env.yml
