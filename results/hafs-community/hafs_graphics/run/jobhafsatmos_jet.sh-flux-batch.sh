flux
#!/bin/bash
#FLUX: --job-name=jobhafsgraph
#FLUX: -N 10
#FLUX: --ntasks-per-node=12
#FLUX: -c 1
#FLUX: -t 1h
#FLUX: --queue=xjet  # Assuming 'xjet' maps to a Flux queue; otherwise, this might need adjustment or removal.
#FLUX: -o jobhafsgraph.log.%j
#FLUX: -e jobhafsgraph.log.%j
#FLUX: --exclusive
# Note: Flux doesn't have direct script equivalents for Slurm's --account or --qos.
# Account is typically handled by user/project association. QOS is often tied to queue properties.
# The -D . (working directory) from Slurm is default Flux behavior.

set -x

date

YMDH=${1:-${YMDH:-2021082800}}
STORM=${STORM:-IDA}
STORMID=${STORMID:-09L}
stormModel=${stormModel:-HFSA}
fhhhAll=$(seq -f "f%03g" 0 3 126)

#HOMEgraph=/your/graph/home/dir
#WORKgraph=/your/graph/work/dir # if not specified, a default location relative to COMhafs will be used
#COMgraph=/your/graph/com/dir   # if not specified, a default location relative to COMhafs will be used
#COMhafs=/your/hafs/com/dir

export HOMEgraph=${HOMEgraph:-/mnt/lfs4/HFIP/hwrfv3/${USER}/hafs_graphics}
export USHgraph=${USHgraph:-${HOMEgraph}/ush}
export DRIVERSH=${USHgraph}/driverAtmos.sh

export COMhafs=${COMhafs:-/hafs/com/${YMDH}/${STORMID}}
export WORKgraph=${WORKgraph:-${COMhafs}/../../../${YMDH}/${STORMID}/emc_graphics}
export COMgraph=${COMgraph:-${COMhafs}/emc_graphics}

source ${