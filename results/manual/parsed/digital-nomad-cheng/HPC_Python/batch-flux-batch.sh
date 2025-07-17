#!/bin/bash
#FLUX: --job-name=misunderstood-diablo-8825
#FLUX: -c=32
#FLUX: -t=169200
#FLUX: --urgency=16

module purge
ml AMGX/2.3.0-foss-2021a-CUDA-11.3.1 SciPy-bundle/2021.05-foss-2021a matplotlib/3.4.2-foss-2021a
ml PyTorch/1.12.1-foss-2021a-CUDA-11.3.1
ml scikit-learn/0.24.2-foss-2021a
./run-python
