#!/bin/bash
#FLUX: --job-name=phytooracle
#FLUX: --queue=standard
#FLUX: -t=86400
#FLUX: --urgency=16

export CCTOOLS_HOME='/home/u12/cosi/cctools-7.1.6-x86_64-centos7'
export PATH='${CCTOOLS_HOME}/bin:$PATH'

module load python/3.8
export CCTOOLS_HOME=/home/u12/cosi/cctools-7.1.6-x86_64-centos7
export PATH=${CCTOOLS_HOME}/bin:$PATH
/home/u12/cosi/cctools-7.1.6-x86_64-centos7/bin/work_queue_factory -T local -M PhytoOracle_FLIR -w 40 -W 90 --workers-per-cycle 10 --cores=1 -t 900
