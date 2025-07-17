#!/bin/bash
#FLUX: --job-name=pycis_${FOLDER}_${WINDOW}.job
#FLUX: --queue=skx-normal
#FLUX: --urgency=16

export OMP_NUM_THREADS='48'

CWD=$(pwd)
ASTRIA_MEASUREMENTS= #Insert location to data folders containing NMSkies telescopes folders
if [ -z ${ASTRIA_MEASUREMENTS} ]; then
echo "ERROR:  PLEASE SPECIFY DATA FOLDER ASTRIA_MEASUREMENTS IN RUNDAILY.SH.  EXITING..."
return 0
fi
declare -a ASTRIA_LIST=("NMSkies_FLI0" "EmeraldAU_FLI0")
COPYLOC="${SCRATCH}/TIP2data"
OUTLOC="${SCRATCH}/TIP2results"
TDMLOC="TDM"
if [ ! -d "$COPYLOC" ]; then
mkdir $COPYLOC
fi
if [ ! -d "$OUTLOC" ]; then
mkdir $OUTLOC
fi
if [ ! -d "$TDMLOC" ]; then
mkdir $TDMLOC
fi
for ASTRIA_FOLDER in "${ASTRIA_LIST[@]}"; do
cp -R -u -p "${ASTRIA_MEASUREMENTS}/${ASTRIA_FOLDER} ${COPYLOC} "
done
module load gcc/9.1
module load cmake/3.16.1 #.10.2
module load python3/3.8.2
module load hdf5
if ! which "solve-field" >& /dev/null ; then
echo "resetting paths"
. setup.sh
fi
timer=120 #runtime in minutes
WINDOW=30
for FOLDER in $COPYLOC/*/; do
FOLDER=${FOLDER%*/}
FOLDER="${FOLDER##*/}"
echo "Writing output to ${COPYLOC}/${FOLDER}/pycis.out"
cat <<EOF |sbatch
module load gcc/9.1
module load cmake/3.16.1
module load python3/3.8.2
module load hdf5
source env/bin/activate
python3 -q -X faulthandler runpycis.py -i ${COPYLOC} -s ${FOLDER} -o ${OUTLOC}/${FOLDER} -t ${TDMLOC} -w $WINDOW
deactivate
EOF
done
