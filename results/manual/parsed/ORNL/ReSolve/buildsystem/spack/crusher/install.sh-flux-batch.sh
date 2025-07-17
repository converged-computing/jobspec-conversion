#!/bin/bash
#FLUX: --job-name=resolve_spack
#FLUX: --queue=batch
#FLUX: -t=14400
#FLUX: --urgency=16

export all_proxy='socks://proxy.ccs.ornl.gov:3128'
export ftp_proxy='ftp://proxy.ccs.ornl.gov:3128'
export http_proxy='http://proxy.ccs.ornl.gov:3128'
export https_proxy='http://proxy.ccs.ornl.gov:3128'
export HTTP_PROXY='http://proxy.ccs.ornl.gov:3128'
export HTTPS_PROXY='http://proxy.ccs.ornl.gov:3128'
export proxy='proxy.ccs.ornl.gov:3128'
export no_proxy='localhost,127.0.0.0/8,*.ccs.ornl.gov,*.olcf.ornl.gov,*.ncrc.gov'
export MY_CLUSTER='crusher'

export all_proxy="socks://proxy.ccs.ornl.gov:3128"
export ftp_proxy="ftp://proxy.ccs.ornl.gov:3128"
export http_proxy="http://proxy.ccs.ornl.gov:3128"
export https_proxy="http://proxy.ccs.ornl.gov:3128"
export HTTP_PROXY="http://proxy.ccs.ornl.gov:3128"
export HTTPS_PROXY="http://proxy.ccs.ornl.gov:3128"
export proxy="proxy.ccs.ornl.gov:3128"
export no_proxy='localhost,127.0.0.0/8,*.ccs.ornl.gov,*.olcf.ornl.gov,*.ncrc.gov'
export MY_CLUSTER=crusher
. buildsystem/load-spack.sh &&
spack mirror add local file://$SPACK_MIRROR &&
spack mirror add spack-public file://$SPACK_MIRROR &&
spack mirror list &&
spack develop --no-clone --path=$(pwd) resolve@develop &&
srun -n 1  ./buildsystem/configure-modules.sh 40
