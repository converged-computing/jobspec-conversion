#!/bin/bash
#SBATCH --output=/group/askap/ban115/craft/archive-logfiles/archivesb-%A_%a.out
#SBATCH --mail-user=keith.bannister@csiro.au
#SBATCH --mail-type=FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=1
#SBATCH --time=1-12:00:00
#SBATCH --constraint=ntasks-per-node=4

export CRAFT='/home/ban115/craft/craft/'
export OMP_NUM_THREADS='24'

export CRAFT=/home/ban115/craft/craft/
export OMP_NUM_THREADS=24
module unload PrgEnv-cray > /dev/null
module unload gcc/4.9.0
module load python/2.7.10 > /dev/null
echo `date` starting archiveSB with $@
CRAFTDATA=/scratch2/askap/askapops/craft/co/
OUTDIR=askap-craft/co
logfile=/group/askap/ban115/craft/archive-logfiles/archived_sbs.txt
for f in $@ ; do
    f=`basename $f`
    echo "ARCHIVING $f"
    dout=$CRAFTDATA/$f
    if [[ ! -d $dout ]]  ; then
	echo "Couldnt archive $dout. Skipping.."
	continue
    fi
    pshell "cd $OUTDIR && import $dout"
    pshellerr=$?
    echo "PSHELL returned exit status: $pshellerr uploading $f"
    if [[ $pshellerr == 0 ]] ;  then
	echo "PSHELL finished successfully - deleting filterbanks"
	echo $f >> $logfile
	#echo find $dout -name '*.fil' -print0 | xargs -0 munlink
	#echo "Delete completed"
    else
	echo "PSHELL Failed with error code $pshellerr. Quitting"
	exit $pshellerr
    fi
done
echo `date` finished archiveSB
