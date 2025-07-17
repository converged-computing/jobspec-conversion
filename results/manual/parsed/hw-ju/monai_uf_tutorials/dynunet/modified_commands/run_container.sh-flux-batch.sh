#!/bin/bash
#FLUX: --job-name=fuzzy-general-9320
#FLUX: -c=4
#FLUX: --queue=gpu
#FLUX: -t=3600
#FLUX: --urgency=16

date;hostname;pwd
module load singularity
echo "pip3 freeze | grep ignite"
singularity exec --nv /blue/vendor-nvidia/hju/monaicore1.0.1 \
pip3 freeze | grep ignite
echo "import ignite; print(ignite.__version__)"
singularity exec --nv /blue/vendor-nvidia/hju/monaicore1.0.1 \
python3 -c "import ignite; print(ignite.__version__)"
