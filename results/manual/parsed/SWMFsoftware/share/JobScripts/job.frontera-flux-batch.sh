#!/bin/bash
#FLUX: --job-name=frigid-bike-7258
#FLUX: --priority=16

export I_MPI_ADJUST_REDUCE='1 '
export UCX_LOG_LEVEL='ERROR '

export I_MPI_ADJUST_REDUCE=1 
export UCX_LOG_LEVEL=ERROR 
ibrun ./SWMF.exe  > runlog_`date +%y%m%d%H%M`
