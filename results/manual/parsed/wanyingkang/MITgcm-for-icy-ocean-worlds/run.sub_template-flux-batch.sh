#!/bin/bash
#FLUX: --job-name=fuzzy-underoos-4086
#FLUX: --exclusive
#FLUX: --priority=16

export casename='_CASENAME_'
export currentiter='_CURRENTITER_'
export eachiter='_EACHITER_'
export totaliter='_TOTALITER_'
export nnodes='_NNODES_'
export ncores='_NCPUS_'

echo Running on host: `hostname`
echo run begins at: `date`
echo Directory: `pwd`
export casename=_CASENAME_
export currentiter=_CURRENTITER_
export eachiter=_EACHITER_
export totaliter=_TOTALITER_
export nnodes=_NNODES_
export ncores=_NCPUS_
if test -f /etc/profile.d/modules.sh    ; then . /etc/profile.d/modules.sh    ; fi
if test -f /etc/profile.d/zz_modules.sh ; then . /etc/profile.d/zz_modules.sh ; fi
if [[ ${SLURM_JOB_PARTITION} == *"hdr"* ]]; then
  module purge
  module load intel/2021.4.0_rhel8
  module load openmpi/3.1.6
elif [[ ${SLURM_JOB_PARTITION} == *"fdr"* || ${SLURM_JOB_PARTITION} == *"edr"* ]]; then
  module add intel/2017.0.1
  module add openmpi
fi
echo "list of loaded modules:"
module list 
echo " "
lk=`readlink flat_*km.bin` # put in some file name that is always linked
inputdir=`dirname $lk`
ln -s $inputdir/* .
datalink=`realpath data`
echo data dir: $datalink
linnumiter0=`grep -n -m1 -i 'nIter0' data | awk -F: '{print $1}'`
sed -i "${linnumiter0}c \\ nIter0=${currentiter}," $datalink
linnumnstep=`grep -n -m1 -i 'nTimeSteps' data | awk -F: '{print $1}'`
sed -i "${linnumnstep}c \\ nTimeSteps=${eachiter}," $datalink
rm -rf grid.t0*
SEQUENCE=`echo ${SLURM_JOB_ID} | awk -F. '{print $1}'`
if [ $ncores -eq 1 ] ; then
    EXE="./mitgcmuv >> stdout.${SEQUENCE} "
else
    EXE="mpirun -np $ncores ./mitgcmuv >> stdout.${SEQUENCE} "
fi
echo "run command: $EXE"
eval $EXE
echo ""
echo "run ended at: "`date`
sed -i 's/^pickupSuff/#pickupSuff/g' $datalink
rm -rf grid.t0*
outStatus=0;
nn=`printf "%10.10i\n" $((currentiter+eachiter))`
if test -f pickup.ckptA.data ; then 
    outStatus=`expr $outStatus + 1` 
    mv pickup.ckptA.data pickup.${nn}.data
    mv pickup.ckptA.meta pickup.${nn}.meta
    if test -f pickup_cd.ckptA.data ; then mv pickup_cd.ckptA.data pickup_cd.${nn}.data; mv pickup_cd.ckptA.meta pickup_cd.${nn}.meta; fi
    if test -f pickup_seaice.ckptA.data ; then mv pickup_seaice.ckptA.data pickup_seaice.${nn}.data; mv pickup_seaice.ckptA.meta pickup_seaice.${nn}.meta; fi
    if test -f pickup_ptracers.ckptA.data ; then mv pickup_ptracers.ckptA.data pickup_ptracers.${nn}.data; mv pickup_ptracers.ckptA.meta pickup_ptracers.${nn}.meta; fi
    if test -f pickup_shelfice.ckptA.data ; then mv pickup_shelfice.ckptA.data pickup_shelfice.${nn}.data; mv pickup_shelfice.ckptA.meta pickup_shelfice.${nn}.meta; fi
fi
if test -f pickup.ckptA.t001.nc; then
    outStatus=`expr $outStatus + 1` 
    rename ckptA $nn pickup*.ckptA*.nc
fi
if [ $outStatus -ne 1 ] ; then
 echo " missing some final pickup file (outStatus=$outStatus) ==> STOP"
 exit
fi 
mkdir run${currentiter}
OUTPUT=`realpath .`
echo $OUTPUT
find . -maxdepth 1 -type f -name '*.meta' -exec mv {} run${currentiter}/ \;
find . -maxdepth 1 -type f -name '*.data' -exec mv {} run${currentiter}/ \;
cp ${OUTPUT}/STDOUT.0000 ${OUTPUT}/STDERR.0000 ${OUTPUT}/run${currentiter}
cp run${currentiter}/pickup* .
if [ $outStatus -eq 1 ]
then
    linnum_matlab=`grep -n -m1 'currentiter=' climatology.m | awk -F: '{print $1}'`
    sed -i "${linnum_matlab}c \\currentiter=${currentiter};" climatology.m
    currentiter=$((currentiter+eachiter))
    linnumiter0=`grep -n -m1 'nIter0' data | awk -F: '{print $1}'`
    sed -i "${linnumiter0}c \\ nIter0=${currentiter}," $datalink
    linnum_currentiter=`grep -n -m1 'export currentiter=' run.sub | awk -F: '{print $1}'`
    sed -i "${linnum_currentiter}c \\ export currentiter=${currentiter}" run.sub
	if [ ${currentiter} -lt ${totaliter} ]
	then
		sbatch run.sub
	else
		exit $runstatus
	fi
fi
