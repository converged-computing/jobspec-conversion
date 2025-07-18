#!/bin/bash
#FLUX: --job-name=demo
#FLUX: --queue=workq
#FLUX: -t=1800
#FLUX: --urgency=16

export LC_ALL='C.UTF-8'
export LANG='C.UTF-8'
export ENV_PREFIX='/project/k1033/${USER}'
export CONDA_PKGS_DIRS='$ENV_PREFIX/conda_cache'
export SCRATCH_DIR='/scratch/${USER}'
export CODE_SERVER_CONFIG_FOLDER='${SCRATCH_DIR}/.config/code-server'
export CODE_SERVER_CONFIG='${CODE_SERVER_CONFIG_FOLDER}/config.yaml'
export XDG_CONFIG_HOME='${SCRATCH_DIR}/tmpdir'
export CODE_SERVER_EXTENSIONS='${SCRATCH_DIR}/code-server/extensions'

export LC_ALL=C.UTF-8
export LANG=C.UTF-8
module swap PrgEnv-cray PrgEnv-intel
export ENV_PREFIX=/project/k1033/${USER}
export CONDA_PKGS_DIRS=$ENV_PREFIX/conda_cache
source $ENV_PREFIX/miniconda3/bin/activate $ENV_PREFIX/install_miniconda_shaheen/env
export SCRATCH_DIR=/scratch/${USER}
export CODE_SERVER_CONFIG_FOLDER=${SCRATCH_DIR}/.config/code-server
export CODE_SERVER_CONFIG=${CODE_SERVER_CONFIG_FOLDER}/config.yaml
export XDG_CONFIG_HOME=${SCRATCH_DIR}/tmpdir
export CODE_SERVER_EXTENSIONS=${SCRATCH_DIR}/code-server/extensions
PROJECT_DIR="$PWD"
PATH="${SCRATCH_DIR}/.local/bin:$PATH"
mkdir -p ${CODE_SERVER_CONFIG_FOLDER} ${SCRATCH_DIR}/data ${XDG_CONFIG_HOME} ${CODE_SERVER_EXTENSIONS} 
COMPUTE_NODE=$(hostname -s) 
CODE_SERVER_PORT=$(python -c 'import socket; s=socket.socket(); s.bind(("", 0)); print(s.getsockname()[1]); s.close()')
submit_host=${SLURM_SUBMIT_HOST} 
gateway=${EPROXY_LOGIN}
if [ ! -f $CODE_SERVER_CONFIG ] ; then 
    touch ${CODE_SERVER_CONFIG}
    echo "bind-addr: 127.0.0.1:8080" >> ${CODE_SERVER_CONFIG} 
    echo "auth: password" >> ${CODE_SERVER_CONFIG}
    echo "password: 10DowningStreet" >> ${CODE_SERVER_CONFIG}
    echo "cert: false" >> ${CODE_SERVER_CONFIG}
fi ; 
echo "
To connect to the compute node ${COMPUTE_NODE} on Shaheen running your Code Server.
Copy the following two lines in a new terminal one after another to create a secure SSH tunnel between your computer and Shaheen compute node.
ssh -L ${CODE_SERVER_PORT}:localhost:${CODE_SERVER_PORT} ${USER}@${submit_host}.hpc.kaust.edu.sa 
ssh -L ${CODE_SERVER_PORT}:${COMPUTE_NODE}:${CODE_SERVER_PORT} ${USER}@${gateway}
Next, you need to copy the url provided below and paste it into the browser 
on your local machine.
localhost:${CODE_SERVER_PORT}
" >&2
code-server --auth none --user-data-dir=${SCRATCH_DIR}/data --bind-addr ${COMPUTE_NODE}:${CODE_SERVER_PORT} --extensions-dir=${CODE_SERVER_EXTENSIONS} "$PROJECT_DIR"
