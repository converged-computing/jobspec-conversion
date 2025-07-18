#!/bin/bash
#FLUX: --job-name=cpl_cors
#FLUX: -t=1800
#FLUX: --urgency=16

export STARTD='`grep "time_init=" $CONFIG | awk '{printf("%1s", $1)}' | tail -c11 | head -c10` '
export DURATION='`grep "^duration=" $CONFIG | sed s/duration=// | awk '{printf("%d", $1)}' `'
export NEXTSIM_MESH_DIR='mesh'
export NEXTSIM_DATA_DIR='data'

function usage {
    echo "Usage:"
    echo "sbatch $0 CONFIG [options]"
    echo "-e|--env-file ENV_FILE"
    echo "   file to be sourced to get environment variables (~/nextsim.src)"
    echo "-m|--mumps-memory MUMPS_MEM"
    echo "   memory reserved for the solver (1000)"
    echo "-d|--debug"
    echo "   divert model printouts into the slurm output file"
    echo "   needed since sometimes the log file is not copied back to the"
    echo "   directory where the job was submitted from"
    echo "-t|--test"
    echo "   don't launch the model"
}
source /cluster/home/annettes/HYCOM-CICE/NERSC-HYCOM-CICE/bin/common_functions.sh
npseaice=4
npocean=4
MUMPS_MEM=1000 # Reserved memory for the solver
ENV_FILE=$HOME/HYCOM-CICE/NERSC-HYCOM-CICE/hycom/RELO/config/nextsim_configuration.src
DEBUG=true
TEST=false
POSITIONAL=()
while [[ $# -gt 0 ]]
do
    key="$1"
    case $key in
        -e|--env-file)
            ENV_FILE=$2
            shift # past argument
            shift # past value
            ;;
        -m|--mumps-memory)
            MUMPS_MEM=$2
            shift # past argument
            shift # past value
            ;;
        -d|--debug)
            DEBUG=true
            shift # past argument
            ;;
        -t|--test)
            TEST=true
            shift # past argument
            ;;
        *)
            # unknown option
            POSITIONAL+=("$1") # save it in an array for later
            shift # past argument
            ;;
    esac
done
set -- "${POSITIONAL[@]}" 
if [ $# -eq 0 ]
then
    usage
    exit 1
else
    CONFIG=$1
fi
module restore system
module load NCL/6.4.0-intel-2017a
module load FFTW/3.3.6-intel-2017a
export STARTD=`grep "time_init=" $CONFIG | awk '{printf("%1s", $1)}' | tail -c11 | head -c10` 
export DURATION=`grep "^duration=" $CONFIG | sed s/duration=// | awk '{printf("%d", $1)}' `
START=`date '+%Y-%m-%dT%H:%M:%S' -d "$STARTD"`
ENDD=`date '+%Y-%m-%dT%H:%M:%S' -d "$STARTD+$DURATION days"`
END=$ENDD
INITFLG="--init"
echo "Start time in pbsjob.sh: $START"
echo "End   time in pbsjob.sh: $END"
echo "Initialization flag is: $INITFLG"
hycom_dir=/cluster/work/users/annettes/TP0a1.00
hycom_exp=$hycom_dir/expt_01.3
source $hycom_dir/REGION.src  || { echo "Could not source ../REGION.src "; exit 1; }
source $hycom_exp/EXPT.src  || { echo "Could not source EXPT.src"; exit 1; }
cd $hycom_exp/
mv $SLURM_SUBMIT_DIR/SCRATCH/arch* $SLURM_SUBMIT_DIR/data/
mv $SLURM_SUBMIT_DIR/SCRATCH/restart* $hycom_exp/data/
mv $SLURM_SUBMIT_DIR/SCRATCH/ovrtn_out $SLURM_SUBMIT_DIR/data/ 
bash ./bin/atmo_synoptic.sh erai+all $START $END
./bin/expt_preprocess.sh $START $END $INITFLG        ||  { echo "Preprocess had fatal errors "; exit 1; }
cp SCRATCH/relax.* $SLURM_SUBMIT_DIR/SCRATCH/ 
cp SCRATCH/restart.* $SLURM_SUBMIT_DIR/SCRATCH/ 
cp SCRATCH/rivers.* $SLURM_SUBMIT_DIR/SCRATCH/ 
cp SCRATCH/regional.* $SLURM_SUBMIT_DIR/SCRATCH/ 
cp SCRATCH/forcing.* $SLURM_SUBMIT_DIR/SCRATCH/ 
cp SCRATCH/blkdat.input $SLURM_SUBMIT_DIR/SCRATCH/ 
cp SCRATCH/patch.input $SLURM_SUBMIT_DIR/SCRATCH/ 
cp SCRATCH/limits $SLURM_SUBMIT_DIR/SCRATCH/ 
cp SCRATCH/co2_annmean_gl.txt $SLURM_SUBMIT_DIR/SCRATCH/ 
cp SCRATCH/hycom_oasis $SLURM_SUBMIT_DIR/SCRATCH/ 
cd $SLURM_SUBMIT_DIR       ||  { echo "Could not go to dir $SLURM_O_WORKDIR  "; exit 1; }
SCRATCH=SCRATCH
echo "Finnished preparing HYCOM files"
echo "SCRATCH" $SCRATCH
if [ -f "$CONFIG" ]
then
    config=$CONFIG
 else
    # if config file is not present, try path relative to
    # directory where job was submitted from
    config=$SLURM_SUBMIT_DIR/$CONFIG
fi
if [ ! -f "$config" ]
then
    echo "Can't find config file $CONFIG"
    echo "- use absolute file path for safety"
    exit 1
fi
if [ ! -f "$ENV_FILE" ]
then
    echo "Can't find environment file $ENV_FILE"
    echo "- use absolute file path for safety"
    exit 1
else
    source $ENV_FILE
fi
config=`basename $config`
log=$(basename $config .cfg).log
OID=OASIS_input
for ddir in data mesh
do
    rm -rf $SCRATCH/$ddir
    mkdir $SCRATCH/$ddir
done
progdir=$SLURM_SUBMIT_DIR/bin
cp -a $CONFIG $SCRATCH
(( DURSEC = $DURATION * 86400 ))
sed s/_totaltime_/$DURSEC/ $OID/namcouple.fabm > $OID/namcouple.tmp
BACLIN=$(blkdat_get $SCRATCH/blkdat.input baclin)
sed s/_baclin_/${BACLIN%%.*}/ $OID/namcouple.tmp > $SCRATCH/namcouple
cp -a $OID/ocean.nc $SCRATCH
cp -a $OID/ice.fabm.nc $SCRATCH/ice.nc
cp -a $log $SCRATCH
cp -a /cluster/home/annettes/Progs/NeXtSIM/nextsim/model/bin/nextsim.exec $progdir/nextsim.exec
cp -a $NEXTSIM_DATA_DIR/* $NEXTSIMDIR/data/* $SCRATCH/data
cp -a $NEXTSIM_MESH_DIR/* $NEXTSIMDIR/mesh/* $SCRATCH/mesh
export NEXTSIM_MESH_DIR=mesh
export NEXTSIM_DATA_DIR=data
cd $SCRATCH
echo "Ready to run, current directory: " $PWD
echo "NextSIM executable: " $progdir/nextsim.exec
echo "HYCOM executable: " hycom_oasis
cmd="mpirun -n $npseaice $progdir/nextsim.exec \
    -mat_mumps_icntl_23 $MUMPS_MEM \
    --config-files=$config : -n $npocean hycom_oasis"
echo $cmd
if [ "$DEBUG" == "true" ]
then
    # model printouts go into the slurm output file
    $cmd 2>&1 | tee $log
else
    $cmd &> $log
fi
savefile $log
