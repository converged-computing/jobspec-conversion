#!/bin/bash
#FLUX: --job-name=boopy-underoos-1395
#FLUX: -t=86400
#FLUX: --priority=16

set -eo pipefail -o nounset
/sf/bernina/anaconda/ahl/bin/dask-worker --nthreads 1 --nprocs 1 --reconnect --nanny --bokeh  --local-directory "/photonics/home/lemke_h/mypy/escape-fel/slurmified_files" sf-cn-1.psi.ch:34628
