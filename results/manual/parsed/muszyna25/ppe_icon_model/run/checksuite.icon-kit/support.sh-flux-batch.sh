#!/bin/bash
#FLUX: --job-name=strawberry-puppy-3350
#FLUX: -N=4
#FLUX: -n=192
#FLUX: --exclusive
#FLUX: --queue=$4
#FLUX: --urgency=16

export OMP_SCHEDULE='static'
export OMP_DYNAMIC='false'
export ATP_ENABLED='1'
export MPICH_RMA_OVER_DMAPP='1'
export OMPI_MCA_pml='cm'
export OMPI_MCA_mtl='mxm'
export OMPI_MCA_mtl_mxm_np='0'
export MXM_RDMA_PORTS='mlx5_0:1'
export MXM_LOG_LEVEL='ERROR'
export OMPI_MCA_coll='^fca'
export MXM_HANDLE_ERRORS='bt'
export UCX_HANDLE_ERRORS='bt'
export OMPI_MCA_coll_hcoll_enable='1'
export OMPI_MCA_coll_hcoll_priority='95'
export OMPI_MCA_coll_hcoll_np='8'
export HCOLL_MAIN_IB='mlx5_0:1'
export HCOLL_ENABLE_MCAST='1'
export HCOLL_ENABLE_MCAST_ALL='1'
export HCOLL_ML_DISABLE_BARRIER='1'
export HCOLL_ML_DISABLE_IBARRIER='1'
export HCOLL_ML_DISABLE_BCAST='1'
export HCOLL_ML_DISABLE_REDUCE='1'

function set_cluster {
echo " Running on " >&2
HPC=`(hostname || uname -n) 2>/dev/null | sed 1q`
case x"$HPC" in #(
xuc1*) :
echo "...UC1 at KIT"; CENTER="IMK"
input_folder="/lsdf/kit/imk/projects/icon/TESTSUITE"
FILETYPE="4"
output_folder="${WORK}/TESTSUITE_OUTPUT"
icon_data_poolFolder=/lsdf/kit/imk/projects/icon/INPUT/AMIP/amip_input
aer_opt="${icon_data_poolFolder}"
;;
xhk*) :
echo "...HoreKa at KIT"; CENTER="IMK"
input_folder="/lsdf/kit/imk/projects/icon/TESTSUITE"
FILETYPE="4"
ws=$(ws_list -s)
if [[ "${ws}" == "" ]]; then
echo "No workspaces found!"
exit
else
ws_id=$(echo $ws | awk '{print $1}')
fi
WORK=/hkfs/work/workspace/scratch/$(whoami)-$ws_id
output_folder="${WORK}/TESTSUITE_OUTPUT"
icon_data_poolFolder=/lsdf/kit/imk/projects/icon/INPUT/AMIP/amip_input
aer_opt="${icon_data_poolFolder}"
;;
xxce*) :
echo "...XCE at DWD"; CENTER="DWD"
. /opt/modules/3.2.10.3/init/ksh
input_folder="${SCRATCH}/TESTSUITE_INPUT/"
output_folder="${WORK}/TESTSUITE_OUTPUT"
FILETYPE="4"
if [[ ":${PE_ENV}" != ':CRAY' ]] ; then
module unload libdwd grib_api
module unload cray-netcdf netcdf perftools stat
module unload craype-hugepages2M
case "{PE_ENV}" in
GNU)   prgenv_="PrgEnv-gnu"   ;;
INTEL) prgenv_="PrgEnv-intel" ;;
esac
module swap ${prgenv_} PrgEnv-cray
fi
module load cray-netcdf perftools stat
module load libdwd
module load grib_api
module list
;;
xlce*) :
echo "...LCE at DWD"; echo "  ERROR: Testsuite has to be run and compiled on XCE !!!", exit 201 ;; #(
xjuwels*) :
echo "...juwels at FZJ"; CENTER="FZJ"
icon_data_poolFolder=/gpfs/homea/hka21/hka211/INPUT/AMIP/atm_amip_base/
FILETYPE="4"
output_folder="${WORK}/TESTSUITE_OUTPUT"
;; #(
xmlogin*) :
echo "...MISTRAL at DKRZ"; CENTER="DKRZ"
icon_data_poolFolder=/pool/data/ICON/grids/private/mpim/icon_preprocessing/source/
input_folder="${WORK}/TESTSUITE/"
FILETYPE="4"
output_folder="/scratch/b/${USER}/TESTSUITE_OUTPUT/"
aer_opt="/pool/data/ICON/grids/public/mpim/independent"
;;
mlogin*)
echo "...MISTRAL at DKRZ"; CENTER="DKRZ"
input_folder="/pfs/imk/ICON/TESTSUITE/"
FILETYPE="4"
output_folder="${SCRATCH}/TESTSUITE_OUTPUT"
icon_data_poolFolder=/pool/data/ICON/grids/private/mpim/icon_preprocessing/source/
aer_opt="/pool/data/ICON/grids/public/mpim/independent"
;;
*) :
echo "...unknown HPC" ; exit 202 ;; #(
esac
ICON_FOLDER=$(pwd)/../..
ART_FOLDER=$ICON_FOLDER/externals/art
}
function read_setup {
i=0
for line in `awk '{print $2}' $1`; do
experiment[$i]=$line
i=`expr $i + 1`
done
i=0
for line in `awk '{print $1}' $1`; do
script[$i]=$line
i=`expr $i + 1`
done
i=0
for line in `awk '{print $3}' $1`; do
config[$i]=$line
i=`expr $i + 1`
done
i=0
for line in `awk '{print $4}' $1`; do
walltime[$i]=$line
i=`expr $i + 1`
done
i=0
for line in `awk '{print $5}' $1`; do
queue[$i]=$line
i=`expr $i + 1`
done
i=0
for line in `awk '{print $6}' $1`; do
nodes[$i]=$line
i=`expr $i + 1`
done
number_of_experiments=$i
}
function usage
{
echo "This is a script for creating buildbot / testsuite / experiment scripts"
echo "for different clusters"
echo "Usage:"
echo "./create_testsuite_runs --input_file=YOUR_FILE"
echo ""
}
function create_header
{
d=`date -d today +%Y%m%d`
complete_output_folder=${output_folder}/${d}/$1
OUTDIR=$complete_output_folder
output_script=$ICON_FOLDER/run/checksuite.icon-kit/runscripts/$1.run
icon_data_poolFolder=$icon_data_poolFolder
EXPERIMENT=$1
lart=$lart
cat > $output_script << EOF
CENTER=$CENTER
basedir=$ICON_FOLDER
icon_data_poolFolder=$icon_data_poolFolder
aer_opt=$aer_opt
EXPNAME=atm_amip_test_kit
OUTDIR=$complete_output_folder
ICONFOLDER=$ICON_FOLDER
ARTFOLDER=$ART_FOLDER
INDIR=$input_folder
EXP=$EXPERIMENT
lart=$lart
FILETYPE=4
COMPILER=intel
restart=.False.
read_restart_namelists=.False.
OUTDIR_PREFIX=`dirname \${OUTDIR}`
if [ ! -d \$OUTDIR ]; then
mkdir -p \$OUTDIR
fi
cd \$OUTDIR
EOF
}
function create_footer
{
output_script=$ICON_FOLDER/run/checksuite.icon-kit/runscripts/$1.run
cat >> $output_script << EOF
cp $ICON_FOLDER/bin/icon ./icon.exe
EOF
case x"$HPC" in #(
xjuwels*)
cat >> $output_script << EOF
cat > job_ICON << ENDFILE
module load Intel
module load ParaStationMPI
module load Python/2.7.14
module load netCDF-Fortran/4.4.4
module load netCDF/4.6.1
srun ./icon.exe
ENDFILE
chmod +x job_ICON
sbatch job_ICON
EOF
;;
xhk*)
cat >> $output_script << EOF
cat > job_ICON << ENDFILE
$5
mpirun --bind-to core --map-by core --report-bindings ./icon.exe
ENDFILE
chmod +x job_ICON
sbatch job_ICON
EOF
;;
xxce*)
cat >> $output_script << EOF
PBS_O_WORKDIR='\${PBS_O_WORKDIR}'
cat > icon.job <<ENDFILEDWD
set -x
if [[ -n "\${PBS_O_WORKDIR}" ]] ; then
cd "\${PBS_O_WORKDIR}"
fi
aprun  -n 72 -N 12 -j 2 -d 4 -m 3g icon.exe
ENDFILEDWD
qsub icon.job
EOF
;;
xmlogin*)
account_id=$(id -gn)
cat >> $output_script << EOF
cat > job_ICON << ENDFILE
ulimit -s 102400
$5
srun -l --propagate=STACK --cpu_bind=cores \
--distribution=block:cyclic ./icon.exe
ENDFILE
chmod +x job_ICON
sbatch job_ICON
EOF
;;
esac
chmod +x $output_script
}
function create_body
{
cat ${ART_FOLDER}/$1 >> $output_script
}
function create_lart_loop_start
{
output_script=$ICON_FOLDER/run/checksuite.icon-kit/runscripts/$1.run
cat >> $output_script << EOF
for iter in 1 2 ; do
if [ \$iter -eq 1 ] ; then
lart=.False.
if [ ! -d $OUTDIR/wo_ART ]; then
mkdir -p $OUTDIR/wo_ART
fi
cd $OUTDIR/wo_ART
OUTDIR=$OUTDIR/wo_ART
else
lart=.True.
if [ ! -d $OUTDIR/w_ART ]; then
mkdir -p $OUTDIR/w_ART
fi
cd $OUTDIR/w_ART
OUTDIR=$OUTDIR/w_ART
fi
EOF
}
function create_lart_loop_end
{
output_script=$ICON_FOLDER/run/checksuite.icon-kit/runscripts/$1.run
cat >> $output_script << EOF
done
EOF
}
function check_action
{
output_script=runscripts/$2.run
case x"$1" in
xrun*)
./$output_script
;;
*none*)
;;
esac
}
function read_configure
{
. $(pwd)/../set-up.info
output="module load ${use_load_modules}"
}
