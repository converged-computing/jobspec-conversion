#!/bin/bash
#FLUX: --job-name=astute-chair-0242
#FLUX: -c=20
#FLUX: --queue=eap
#FLUX: -t=3600
#FLUX: --urgency=16

module --quiet purge
module load cray-python
source venv/bin/activate
cd apex
python setup.py install --cpp_ext --cuda_ext
