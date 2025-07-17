#!/bin/bash
#FLUX: --job-name=gtsm_xynthia_2010
#FLUX: --queue=thin
#FLUX: -t=37800
#FLUX: --urgency=16

export purpose='GTSMv3.0 - ERA5 run near-realtime for Sea Level Monitor'

export purpose="GTSMv3.0 - ERA5 run near-realtime for Sea Level Monitor"
echo "========================================================================="
echo "Submitting Dflow-FM run $name in  $PWD"
echo "Purpose: $purpose"
echo "Starting on $SLURM_NTASKS domains, SLURM_NNODES nodes"
echo "Wall-clock-limit set to $maxwalltime"
echo "========================================================================="
set -e
module purge
module load 2021
module load intel/2021a
modelFolder=${PWD}
singularityFolder=/gpfs/home6/hmoreno/delft3dfm_2022.04/
echo modelFolder
mduFile=gtsm_fine_xynthia.mdu
$singularityFolder/execute_singularity_snellius.sh $modelFolder run_dflowfm.sh --partition:ndomains=$SLURM_NTASKS:icgsolver=6 $mduFile
$singularityFolder/execute_singularity_snellius.sh $modelFolder run_dflowfm.sh -m $mduFile #--savenet #$dimrFile
touch $SBATCH_JOB_NAME.done
