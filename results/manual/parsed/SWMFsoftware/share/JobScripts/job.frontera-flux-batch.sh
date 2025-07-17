#!/bin/bash
#FLUX: --job-name=sub1
#FLUX: -N=64
#FLUX: --queue=normal
#FLUX: -t=86400
#FLUX: --urgency=16

export I_MPI_ADJUST_REDUCE='1 '
export UCX_LOG_LEVEL='ERROR '

export I_MPI_ADJUST_REDUCE=1 
export UCX_LOG_LEVEL=ERROR 
ibrun ./SWMF.exe  > runlog_`date +%y%m%d%H%M`
