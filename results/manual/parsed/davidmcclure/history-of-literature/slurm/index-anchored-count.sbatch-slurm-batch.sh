#!/bin/bash
#FLUX: --job-name=index-anchored-count
#FLUX: -N=16
#FLUX: -t=43200
#FLUX: --urgency=16

export PYTHONPATH='/home/dclure/history-of-literature'

module load openmpi/1.10.2/gcc
module load python/3.3.2
export PYTHONPATH=/home/dclure/history-of-literature
mpirun -x PYTHONPATH $PYTHONPATH/env/bin/python \
    $PYTHONPATH/bin/index_anchored_count "literature"
