#!/bin/bash
#FLUX: --job-name=eccentric-plant-2118
#FLUX: --urgency=16

module load singularity
SINGIMAGE='/share/resources/containers/singularity/rhessys'
BASEDIR='/scratch/js4yd/MorrisSA'
EPSGCODE='EPSG:26918'
RESOLUTION=30 #spatial resolution (meters) of the grids
RHESSysNAME='RHESSys_Baisman30m_g74' # e.g., rhessys_baisman10m
LOCATION_NAME="g74_$RHESSysNAME"
MAPSET=PERMANENT
RHESSysModelLoc="/scratch/js4yd/RHESSysEastCoast"
SUBONE=1
i=$(expr ${SLURM_ARRAY_TASK_ID} - $SUBONE) 
PROJDIR="$BASEDIR"/RHESSysRuns/Run"$i" 
cd "$PROJDIR"/"$RHESSysNAME"
"$RHESSysModelLoc"/rhessys5.20.0.develop -st 1999 11 15 1 -ed 2010 10 1 1 -b -h -newcaprise -gwtoriparian -capMax 0.01 -slowDrain -t tecfiles/tec_daily_SA.txt -w worldfiles/worldfile -whdr worldfiles/worldfile.hdr -r flows/subflow.txt flows/surfflow.txt -pre output/BaismanRun"$i" -s 1 1 1 -sv 1 1 -gw 1 1 -svalt 1 1 -vgsen 1 1 1 -snowTs 1 -snowEs 1 -capr 0.001
rm -r "$PROJDIR"/"$RHESSysNAME"/flows
rm -r "$PROJDIR"/"$RHESSysNAME"/clim
rm -r "$PROJDIR"/"$RHESSysNAME"/tecfiles
