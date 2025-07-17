#!/bin/bash
#FLUX: --job-name=pycis.job
#FLUX: --queue=skx-normal
#FLUX: --urgency=16

export OMP_NUM_THREADS='48'

CWD=$(pwd)
COPYLOC="$CWD/data"
OUTLOC="$CWD/results"
TDMLOC="$CWD/TDM"
if [ ! -d "$COPYLOC" ]; then
echo "ERROR: PLEASE DOWNLOAD DEMO DATA INTO THE DATA FOLDER"
echo "aborting..."
return 0
fi
if [ ! -d "$OUTLOC" ]; then
mkdir $OUTLOC
fi
if [ ! -d "$TDMLOC" ]; then
mkdir $TDMLOC
fi
timer=60 #runtime in minutes
sleeper=2 #sleep time in minutes (to close scripts)
for FOLDER in $COPYLOC/*/; do
FOLDER=${FOLDER%*/}
FOLDER="${FOLDER##*/}"
if ! type "sbatch" >& /dev/null; then
echo "launching on bash"
if ! which "solve-field" >& /dev/null ; then
echo "resetting paths"
. setup.sh
fi
source env/bin/activate
python3 -q -X faulthandler demo.py
python3 -q -X faulthandler runpycis.py -i $COPYLOC -s $FOLDER -o $OUTLOC/$FOLDER -t $TDMLOC
deactivate
else
echo "launching through slurm"
module load gcc/9.1
module load cmake/3.16.1 #.10.2
module load python3/3.8.2
if ! which "solve-field" >& /dev/null ; then
echo "resetting paths"
. setup.sh
fi
cat <<EOF |sbatch
module load gcc/9.1
module load cmake/3.10.2
module load python3/3.8.2
source env/bin/activate
python3 -q -X faulthandler runpycis.py -i $COPYLOC -s $FOLDER -o $OUTLOC/$FOLDER -t $TDMLOC
deactivate
EOF
fi
done
