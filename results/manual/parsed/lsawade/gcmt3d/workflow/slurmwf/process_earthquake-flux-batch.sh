#!/bin/bash
#FLUX: --job-name=invert_C$CID
#FLUX: -N=2
#FLUX: -t=600
#FLUX: --urgency=16

export OMP_NUM_THREADS='1'

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
echo "******** CONVERT TRACES ******************************"
echo " "
CONV_LOG=$LOG_DIR/$CID.005.Converting-to-ASDF
for CMT in "\${CMT_LIST[@]}"; do
    CONV_PATH_FILE=$CMT_SIM_DIR/\$CMT/\$CMT.yml
    echo "Conversion yml: \$CONV_PATH_FILE"
    CONV_LOG_FILE=\$CONV_LOG.\$CMT.STDOUT
    echo "Conversion logfile: \$CONV_LOG_FILE"
    srun -N1 -n1 convert2asdf -f \$CONV_PATH_FILE > \$CONV_LOG_FILE &
done                                                   
CONV_PATH_FILE=$CDIR/seismograms/obs/observed.yml
echo "Conversion yml: \$CONV_PATH_FILE"
CONV_LOG_FILE=\$CONV_LOG.observed.STDOUT
echo "Conversion logfile: \$CONV_LOG_FILE"
srun -N1 -n1 convert2asdf -f \$CONV_PATH_FILE > \$CONV_LOG_FILE
wait
echo " "
echo "Done."
echo " "
echo " "
echo "******** CREATE PROCESS PATHS ************************"
echo " "
CPP_LOG_FILE="$LOG_DIR/$CID.006.Create-Process-Paths.STDOUT"
echo "Create Process Paths Logfile: \$CPP_LOG_FILE"
srun -N1 -n1 create-path-files -f $CIN_DB -p $PARAMETER_PATH > \$CPP_LOG_FILE
echo " "
echo "******** PROCESS TRACES ******************************"
echo " "
PROCESS_LOG="$LOG_DIR/$CID.007.Process-Traces"
export OMP_NUM_THREADS=1
BAND_LIST=\$(for path in \$(ls $PROCESS_PATHS); do echo \$(echo \$path | cut -d. -f2); done | sort | uniq)
echo \$BAND_LIST
for BAND in \$BAND_LIST; do
    for PROCESS_PATH in \$(ls $PROCESS_PATHS); do
        if [[ \$PROCESS_PATH == *"\$BAND"* ]]; then
            PROCESS_PATH_FILE="$PROCESS_PATHS/\$PROCESS_PATH"
            echo "Processing yml: \$PROCESS_PATH_FILE"
            PROC_LOG_FILE="\$PROCESS_LOG.\$PROCESS_PATH.STDOUT"
            echo "Processing logfile: \$PROC_LOG_FILE"
            srun -N1 -n1 process-asdf -f \$PROCESS_PATH_FILE > \$PROC_LOG_FILE &
        fi
    done
    wait
done
echo " "
echo "Done."
echo " "
echo " "   
exit 0
EOF
