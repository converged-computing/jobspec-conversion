#!/bin/bash
#FLUX: --job-name=invert_C$CID
#FLUX: -N=2
#FLUX: -t=600
#FLUX: --urgency=16

CMTSOLUTION=$1
if [ -z "$CMTSOLUTION" ]
then
      echo "No CMTSOLUTION INPUT is empty. Stopping. Choose earthquake"
      exit 1
else
      echo "Inverting $(realpath $CMTSOLUTION)"
fi
GCMT3D='/home/lsawade/GCMT3D'
WORKFLOW_DIR="$GCMT3D/workflow"
PARAMETER_PATH="$WORKFLOW_DIR/params"
SLURM_DIR="$WORKFLOW_DIR/slurmwf"
DATABASE_DIR='/scratch/gpfs/lsawade/database'
CID=`cat $CMTSOLUTION | head -2 | tail -1 | cut -d: -f2 | tr -d '[:space:]'`
CIN_DB="$DATABASE_DIR/C$CID/C$CID.cmt"
CDIR=`dirname $CIN_DB` # Earthquake Directory
CMT_SIM_DIR=$CDIR/CMT_SIMs # Simulation directory
PROCESS_PATHS=$CDIR/seismograms/process_paths # Process Path directory
PROCESSED=$CDIR/seismograms/processed_seismograms # Processed dir
SEISMOGRAMS=$CDIR/seismograms # Seismos
STATION_DATA=$CDIR/station_data
LOG_DIR=$CDIR/logs # Logging directory
INVERSION_OUTPUT_DIR=$CDIR/inversion/inversion_output
WINDOW_PATHS=$CDIR/window_data/window_paths
echo
echo "******** PACKAGE INFO ********************************"
echo "GCMT3D Location:_________________ $GCMT3D"
echo "Workflow Directory:______________ $WORKFLOW_DIR"
echo "Slurmjob Directory:______________ $SLURM_DIR"
echo "Bin directory (important):_______ $BIN_DIR" 
echo
echo
echo "******** DATABASE INFO *******************************"
echo "Database directory:______________ $DATABASE_DIR"
echo
echo
echo "******** EARTHQUAKE INFO *****************************"
echo "CMTSOLUTION:_____________________ $CMTSOLUTION"
echo "Earthquake ID:___________________ $CID"
echo "Earthquake Directory:____________ $CDIR"
echo "Earthquake File in Database:_____ $CIN_DB"
echo "Inversion Logging Directory:_____ $LOG_DIR"
echo "Simulation Directory:____________ $CMT_SIM_DIR"
echo "Process Path Directory:__________ $PROCESS_PATHS"
echo "Window Path Directory:___________ $WINDOW_PATHS"
echo
echo
sbatch << EOF
module purge
module load anaconda3
conda activate gcmt3d
module load openmpi/gcc
module load cudatoolkit/10.0
CMT_LIST=(CMT CMT_rr CMT_tt CMT_pp CMT_rt CMT_rp CMT_tp CMT_depth CMT_lat CMT_lon)
echo "******** WINDOW TRACES *******************************"
echo " "
WINDOW_LOG="$LOG_DIR/$CID.008.Window-Traces"
for WINDOW_PATH in \$(ls $WINDOW_PATHS); do
    if [[ \$WINDOW_PATH != *"#surface"* ]]; then
        WINDOW_PATH_FILE="$WINDOW_PATHS/\$WINDOW_PATH"
        echo "Processing yml: \$WINDOW_PATH_FILE"
        WIND_LOG_FILE="\$WINDOW_LOG.\$WINDOW_PATH.STDOUT"
        echo "Processing logfile: \$WIND_LOG_FILE"
        srun -N1 -n25 select-windows -f \$WINDOW_PATH_FILE > \$WIND_LOG_FILE &
    fi
done 
wait
for WINDOW_PATH in \$(ls $WINDOW_PATHS); do
    if [[ \$WINDOW_PATH == *"#surface"* ]]; then
        WINDOW_PATH_FILE="$WINDOW_PATHS/\$WINDOW_PATH"
        echo "Processing yml: \$WINDOW_PATH_FILE"
        WIND_LOG_FILE="\$WINDOW_LOG.\$WINDOW_PATH.STDOUT"
        echo "Processing logfile: \$WIND_LOG_FILE"
        srun -N1 -n25 select-windows -f \$WINDOW_PATH_FILE > \$WIND_LOG_FILE
    fi
done
echo " "
echo "Done."
echo " "
echo " "
exit 0
EOF
