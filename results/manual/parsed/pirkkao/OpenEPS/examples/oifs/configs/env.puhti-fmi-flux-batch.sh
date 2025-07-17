#!/bin/bash
#FLUX: --job-name=persnickety-ricecake-4142
#FLUX: --urgency=16

export ECCODES_SAMPLES_PATH='${ECCODES_INSTALL_ROOT}/share/eccodes/ifs_samples/grib1_mlgrib2'
export GRIBTOOLS='/appl/spack/install-tree/intel-19.0.4/eccodes-2.5.0-dpk7ts/bin'

SYS_CPUSPERNODE=20
if [ -z $CPUSTOT ]; then
    CPUSTOT=$(echo "$NNODES * $SYS_CPUSPERNODE" | bc)
fi
export CPUSTOT
WORK=/fmi/scratch/project_2002141/openEPS/${EXPL}_puhti
SCRI=$WORK/scripts
DATA=$WORK/data
SRC=$WORK/configs
export WORK SCRI DATA SRC
if [ -z $EXPTIME ]; then
    mandtg=$WORK/mandtg
    totperday=$(echo "$TIMEFORMODEL * $ENS" | bc)
    totdays=$($mandtg $EDATE - $SDATE)
    totdays=$(echo "$totdays / $DSTEP + 1" | bc)
    totmins=$(echo "$totperday * $totdays" | bc)
    parallels=$(echo "$CPUSTOT / $CPUSPERMODEL" | bc)
    tottime=$(echo "$totmins / $parallels" | bc)
    modul=$(printf '%02d' $(($tottime % 60)))
    EXPTIME=$(echo "$tottime / 60" | bc)":$modul:00"
fi
export EXPTIME
if [ -z $BATCHQUEUE ]; then
    BATCHQUEUE=fmi
fi
launcher="srun --exclusive -n $CPUSPERMODEL"
export launcher
SEND_AS_SINGLEJOB="true" # send whole main.bash to queue
SEND_AS_MULTIJOB="false"   # only send run.bash to queue
line1="#SBATCH -p $BATCHQUEUE"       # batchjob queue
line2="#SBATCH -J $EXPS"             # name
line3="#SBATCH -t $EXPTIME"          # time reservation
line4="#SBATCH -n $CPUSTOT"          # cores tot
line5='#SBATCH --mem-per-cpu=4000'   # memory per core in MB
line6='#SBATCH -o out'               # where to write output 
line7='#SBATCH -e err'               # where to write error
line8='#SBATCH --account=project_2002141'
module purge
module load intel/19.0.4 hpcx-mpi/2.4.0 intel-mkl/2019.0.4
module load eccodes perl fftw/3.3.8-mpi netcdf/4.7.0 netcdf-fortran/4.4.4
module load cdo
if [ -z $OIFSv ]; then
    OIFSv=43r3v1
else
    if [ $OIFSv == "38r1v04" ]; then
	echo "OIFS version $OIFSv NOT supported in this env, using default instead"
	OIFSv=43r3v1
    fi
fi
export OIFSv
if [ -z $MODEL_EXE ]; then
    if [ $OIFSv == "43r3v1" ]; then
	MODEL_EXE=/projappl/project_2001011/OpenIFS/intel_19.0.4/cy43r3v1/master.exe
    else
	MODEL_EXE=/projappl/project_2001011/OpenIFS/intel_19.0.4/cy40r1v2/master.exe
    fi
fi
export ECCODES_SAMPLES_PATH=${ECCODES_INSTALL_ROOT}/share/eccodes/ifs_samples/grib1_mlgrib2
INIBASEDIR=/fmi/scratch/project_2002141/OIFS_INI
IFSDATA=$INIBASEDIR
export MODEL_EXE
export INIBASEDIR IFSDATA IFSDATA2 GRIB_SAMPLES_PATH
export LD_LIBRARY_PATH
ulimit -s unlimited
export GRIBTOOLS=/appl/spack/install-tree/intel-19.0.4/eccodes-2.5.0-dpk7ts/bin
REQUIRE_NAMEL="namelist_general.bash namelist_${OIFSv}.bash"
REQUIRE_PATHS="$REQUIRE_PATHS MODEL_EXE INIBASEDIR IFSDATA GRIB_SAMPLES_PATH"
REQUIRE_VARS="$REQUIRE_VARS WORK SCRI DATA SRC OMP_NUM_THREADS DR_HOOK"
