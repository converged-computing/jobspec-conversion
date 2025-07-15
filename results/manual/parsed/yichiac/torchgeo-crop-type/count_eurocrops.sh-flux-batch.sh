#!/bin/bash
#FLUX: --job-name=count_euro
#FLUX: --queue=dali
#FLUX: -t=43200
#FLUX: --urgency=16

. /projects/dali/spack/share/spack/setup-env.sh
spack env activate dali
python3 count.py
