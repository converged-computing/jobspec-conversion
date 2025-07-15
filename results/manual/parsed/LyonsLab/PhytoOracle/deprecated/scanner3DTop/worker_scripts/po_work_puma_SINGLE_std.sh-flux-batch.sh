#!/bin/bash
#FLUX: --job-name="phytooracle"
#FLUX: -t=86400
#FLUX: --priority=16

export CCTOOLS_HOME='/home/u12/cosi/cctools-7.1.6-x86_64-centos7'
export PATH='${CCTOOLS_HOME}/bin:$PATH'

module load python/3.8
export CCTOOLS_HOME=/home/u12/cosi/cctools-7.1.6-x86_64-centos7
export PATH=${CCTOOLS_HOME}/bin:$PATH
/home/u12/cosi/cctools-7.1.6-x86_64-centos7/bin/work_queue_worker -M PhytoOracle_3D -t 900
