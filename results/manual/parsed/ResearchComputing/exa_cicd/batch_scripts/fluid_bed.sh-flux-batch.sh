#!/bin/bash
#FLUX: --job-name=blue-bike-3551
#FLUX: -N=4
#FLUX: --exclusive
#FLUX: -t=57600
#FLUX: --urgency=16

export COMMIT_HASH='$1'
export WD='$2'
export ES_INDEX='$3'
export RUN_DATE='$(date '+%Y-%m-%d_%H-%M-%S')'
export MFIX='/app/mfix/build/mfix'
export IMAGE='/scratch/summit/holtat/singularity/mfix-exa_${BRANCH}_${COMMIT_HASH}.sif'
export MPIRUN='/pl/active/mfix/holtat/openmpi-2.1.6-install/bin/mpirun'
export dir='np_0024'
export GAS_FRACTION='${BASE}/${ES_INDEX}/${dir}/gafraction_${BRANCH}_${COMMIT_HASH}_${RUN_DATE}'
export VELOCITY='${BASE}/${ES_INDEX}/${dir}/velocity_${BRANCH}_${COMMIT_HASH}_${RUN_DATE}'
export VIDEO_BASE='/videos/${ES_INDEX}/${dir}/${BRANCH}_${COMMIT_HASH}_${RUN_DATE}'
export VELOCITY_COMPARE='/projects/holtat/CICD/exa_cicd/python_scripts/fluid_bed_velocity_compare.py'
export GAS_COMPARE='/projects/holtat/CICD/exa_cicd/python_scripts/fluid_bed_gas_fraction_compare.py'
export BASE='/projects/jenkins/images'
export PVPYTHON='/projects/jenkins/ParaView-5.8.0-osmesa-MPI-Linux-Python3.7-64bit/bin/pvpython'
export PARAVIEW_ANIMATE='/projects/holtat/CICD/exa_cicd/python_scripts/paraview_animation.py'

export COMMIT_HASH=$1
export WD=$2
export ES_INDEX=$3
export RUN_DATE=$(date '+%Y-%m-%d_%H-%M-%S')
echo 'COMMIT_HASH'
echo $COMMIT_HASH
cp -r --no-clobber /projects/holtat/CICD/fluid_bed/* $WD
source /etc/profile.d/lmod.sh
ml use /pl/active/mfix/holtat/modules
ml singularity/3.6.4 gcc/8.2.0 openmpi_2.1.6
cd /scratch/summit/holtat/singularity
singularity pull --allow-unsigned --force library://aarontholt/default/mfix-exa:${BRANCH}_${COMMIT_HASH}
export MFIX=/app/mfix/build/mfix
export IMAGE=/scratch/summit/holtat/singularity/mfix-exa_${BRANCH}_${COMMIT_HASH}.sif
export MPIRUN=/pl/active/mfix/holtat/openmpi-2.1.6-install/bin/mpirun
hostnames=()
for host in $(scontrol show hostnames); do
  #echo $host; mpirun --host $host -n 2 hostname &
  hostnames+=( $host )
done;
export dir=np_0024
mkdir -p $WD/$dir
cd $WD/$dir
rm -rf flubed*
rm -rf normal*
rm -rf adapt*
rm -rf morton*
rm -rf combined*
pwd
np=${dir:(-4)}
np=$((10#$np))
echo "HOSTNAMES"
echo ${hostnames[0]}
echo ${hostnames[1]}
echo ${hostnames[2]}
echo ${hostnames[3]}
$MPIRUN --host ${hostnames[0]} -np $np singularity exec $IMAGE bash -c "$MFIX inputs amr.plot_file=normal >> ${RUN_DATE}_${COMMIT_HASH}_${dir}_normal" &
$MPIRUN --host ${hostnames[1]} -np $np singularity exec $IMAGE bash -c "$MFIX inputs mfix.use_tstepadapt=1 amr.plot_file=adapt >> ${RUN_DATE}_${COMMIT_HASH}_${dir}_adapt" &
$MPIRUN --host ${hostnames[2]} -np $np singularity exec $IMAGE bash -c "$MFIX inputs mfix.sorting_type=1 amr.plot_file=morton >> ${RUN_DATE}_${COMMIT_HASH}_${dir}_morton" &
$MPIRUN --host ${hostnames[3]} -np $np singularity exec $IMAGE bash -c "$MFIX inputs mfix.sorting_type=1 mfix.use_tstepadapt=1 amr.plot_file=combined >> ${RUN_DATE}_${COMMIT_HASH}_${dir}_combined" &
wait
ml python_3.8.2 git
source /projects/holtat/CICD/cicd_py38_env/bin/activate
cd /projects/holtat/CICD/exa_cicd/Elasticsearch
git pull
export dir=np_0024
np=${dir:(-4)}
export GAS_FRACTION="/images/${ES_INDEX}/${dir}/gafraction_${BRANCH}_${COMMIT_HASH}_${RUN_DATE}"
export VELOCITY="/images/${ES_INDEX}/${dir}/velocity_${BRANCH}_${COMMIT_HASH}_${RUN_DATE}"
export VIDEO_BASE="/videos/${ES_INDEX}/${dir}/${BRANCH}_${COMMIT_HASH}_${RUN_DATE}"
declare -a options_array=("normal" "morton" "adapt" "combined")
for option in "${options_array[@]}"
do
    python3 output_to_es.py --es-index $ES_INDEX --work-dir $WD --np $np \
            --git-hash $COMMIT_HASH --git-branch $BRANCH --sing-image-path $IMAGE \
            --gas-fraction-image-url "${GAS_FRACTION}_${option}.png" \
            --velocity-image-url "${VELOCITY}_${option}.png" \
            --video-url "${VIDEO_BASE}_${option}.avi" \
            --mfix-output-path "$WD/$dir/${RUN_DATE}_${COMMIT_HASH}_${dir}_${option}" \
            --type $option
done
export VELOCITY_COMPARE=/projects/holtat/CICD/exa_cicd/python_scripts/fluid_bed_velocity_compare.py
export GAS_COMPARE=/projects/holtat/CICD/exa_cicd/python_scripts/fluid_bed_gas_fraction_compare.py
export dir=np_0024
cd $WD/$dir
export BASE="/projects/jenkins/images"
export GAS_FRACTION="${BASE}/${ES_INDEX}/${dir}/gafraction_${BRANCH}_${COMMIT_HASH}_${RUN_DATE}"
export VELOCITY="${BASE}/${ES_INDEX}/${dir}/velocity_${BRANCH}_${COMMIT_HASH}_${RUN_DATE}"
echo "Plot locations: ${GAS_FRACTION} ${VELOCITY}"
for option in "${options_array[@]}"
do
    python3 $VELOCITY_COMPARE -pfp "${option}*" --outfile "${VELOCITY}_${option}.png";
    python3 $GAS_COMPARE -pfp "${option}*" --outfile "${GAS_FRACTION}_${option}.png";
done
ml purge
deactivate
export PVPYTHON=/projects/jenkins/ParaView-5.8.0-osmesa-MPI-Linux-Python3.7-64bit/bin/pvpython
export PARAVIEW_ANIMATE=/projects/holtat/CICD/exa_cicd/python_scripts/paraview_animation.py
for option in "${options_array[@]}"
do
    $PVPYTHON $PARAVIEW_ANIMATE \
          --outfile="/projects/jenkins/videos/${ES_INDEX}/${dir}/${BRANCH}_${COMMIT_HASH}_${RUN_DATE}_${option}.avi" \
          --plot-file-prefix="/scratch/summit/holtat/fluid-bed/np_0024/${option}" \
          --low-index=0 \
          --high-index=10000 \
          --index-step=500 \
          --camera-focal-point 0.08 0.02 0 \
          --camera-position 0.08 0.02 0.4
done
