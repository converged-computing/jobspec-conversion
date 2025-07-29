#!/bin/bash
#FLUX: --job-name=vo_pes_MOLECULE
#FLUX: --queue=pbatch
#FLUX: -t=1800
#FLUX: --urgency=16

export NCCL_DEBUG='INFO'
export PYTHONFAULTHANDLER='1'
export MASTER_ADDR='$(hostname)'

module load gcc/8.3.1
module load cuda/11.6.1
source /g/g20/vita1/venv-ruby/bin/activate
export NCCL_DEBUG=INFO
export PYTHONFAULTHANDLER=1
export MASTER_ADDR=$(hostname)
LOG_DIR='/g/g20/vita1/ws/logs/ip_explorer/AL_Al/vgop'
PREFIX=''
DIMENSIONS=2
sheap -v -hs -rs -1 -p 20 -st 1.0 -dim $DIMENSIONS < "${LOG_DIR}/${PREFIX}representations.xyz" > "${LOG_DIR}/${PREFIX}sheap-${DIMENSIONS}d.xyz"
python3 -m ip_explorer.pes \
    --load-dir ${LOG_DIR} \
    --prefix ${PREFIX} \
    --n-components ${DIMENSIONS} \
    --scale 0.1 \
