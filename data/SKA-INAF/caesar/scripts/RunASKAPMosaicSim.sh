#!/bin/bash

NARGS="$#"
echo "INFO: NARGS= $NARGS"

if [ "$NARGS" -lt 2 ]; then
	echo "ERROR: Invalid number of arguments...see script usage!"
  echo ""
	echo "**************************"
  echo "***     USAGE          ***"
	echo "**************************"
 	echo "$0 [ARGS]"
	echo ""
	echo "=========================="
	echo "==    ARGUMENT LIST     =="
	echo "=========================="
	echo "*** MANDATORY ARGS ***"
	echo "--mosaic=[MOSAIC_FILE] - Input mosaic map filename (.fits/casa)"
	echo "--weights=[FILELIST_WEIGHTS] - Input filelist with weights images (casa) for all beams"
	echo "--residuals=[FILELIST_RESIDUALS] - Input filelist with clean residual images (casa/fits) for all beams"
	echo "--restoredimgs=[FILELIST_IMGS] - Input filelist with restored images (casa/fits) for all beams"
	echo ""	

	echo "*** OPTIONAL ARGS ***"
	echo "=== SKYMODEL SIM OPTIONS ==="	
	echo "--smin=[SMIN] - Min generated compact source flux density in Jy (default: 1.e-4)"
	echo "--smax=[SMAX] - Max generated compact source flux density in Jy (default: 1)"
	echo "--nsources=[NSOURCES] - Number of compact sources generated in mosaic (if >0 override source density options) (default: 0)"
	echo "--sourcedensity=[SOURCE_DENSITY] - Compact source density in sources/deg^2 (default: 1000)"
	echo ""

	echo "=== RUN OPTIONS ==="	
	echo "--envfile=[ENV_FILE] - File (.sh) with list of environment variables to be loaded by each processing node"
	echo "--startid=[START_ID] - Run start id (default: 1)"	
	echo "--maxfiles=[NMAX_PROCESSED_FILES] - Maximum number of input files processed in filelist (default=-1=all files)"
	echo "--addrunindex - Append a run index to submission script (in case of list execution) (default=no)"	
	echo "--containerrun - Run inside ASKAPSoft container"
	echo "--containerimg=[CONTAINER_IMG] - Singularity container image file (.simg) with ASKAPSoft installed software"
	echo "--containeroptions=[CONTAINER_OPTIONS] - Options to be passed to container run (e.g. -B /home/user:/home/user) (default=none)"	
	echo ""
	
	echo "=== SUBMISSION OPTIONS ==="
	echo "--submit - Submit the script to the batch system using queue specified"
	echo "--queue=[BATCH_QUEUE] - Name of queue in batch system"
	echo "--jobwalltime=[JOB_WALLTIME] - Job wall time in batch system (default=96:00:00)"
	echo "--jobmemory=[JOB_MEMORY] - Memory in GB required for the job (default=4)"
	echo "--jobusergroup=[JOB_USER_GROUP] - Name of job user group batch system (default=empty)"
	echo "=========================="

	exit 1
fi

#######################################
##         PARSE ARGS
#######################################
## MANDATORY OPTIONS
MOSAIC_FILE=""
FILELIST_WEIGHTS=""
FILELIST_RESIDUALS=""
FILELIST_IMGS=""

## SKYMODEL GEN DEFAULT OPTIONS
SMIN=1.e-4
SMAX=1
SOURCE_DENSITY=1000
NSOURCES=0

## RUN DEFAULT OPTIONS
ENV_FILE=""
NRUNS=1
NRUNS_GIVEN=false
START_ID=1
CONTAINER_IMG=""
RUN_IN_CONTAINER=false
CONTAINER_OPTIONS=""

## SUBMIT DEFAULT OPTIONS
SUBMIT=false
BATCH_QUEUE=""
JOB_WALLTIME="96:00:00"
JOB_MEMORY="4"
JOB_USER_GROUP=""
JOB_USER_GROUP_OPTION=""

##for item in $*
for item in "$@"
do
	case $item in 
		## MANDATORY ##	
		--mosaic=*)
			MOSAIC_FILE=`echo $item | sed 's/[-a-zA-Z0-9]*=//'`	
		;;

		--weights=*)
    	FILELIST_WEIGHTS=`echo $item | sed 's/[-a-zA-Z0-9]*=//'`
    ;;
		--residuals=*)
    	FILELIST_RESIDUALS=`echo $item | sed 's/[-a-zA-Z0-9]*=//'`
    ;;
		--restoredimgs=*)
    	FILELIST_IMGS=`echo $item | sed 's/[-a-zA-Z0-9]*=//'`
    ;;
		
		

		## SKY MODEL SIM ##		
		--nsources=*)
			NSOURCES=`echo $item | sed 's/[-a-zA-Z0-9]*=//'`	
		;;
		--sourcedensity=*)
    	SOURCE_DENSITY=`echo $item | sed 's/[-a-zA-Z0-9]*=//'`		
    ;;
		--smin=*)
    	SMIN=`echo $item | sed 's/[-a-zA-Z0-9]*=//'`		
    ;;
		--smax=*)
    	SMAX=`echo $item | sed 's/[-a-zA-Z0-9]*=//'`		
    ;;
			
		## RUN OPTIONS	
		--envfile=*)
    	ENV_FILE=`echo $item | sed 's/[-a-zA-Z0-9]*=//'`
    ;;
		--nruns=*)
    	NRUNS=`echo $item | sed 's/[-a-zA-Z0-9]*=//'`
			if [ "$NRUNS" != "" ]; then
				NRUNS_GIVEN=true
			fi
    ;;
		--startid=*)
    	START_ID=`echo $item | sed 's/[-a-zA-Z0-9]*=//'`		
    ;;	
		--containerimg=*)
    	CONTAINER_IMG=`echo $item | sed 's/[-a-zA-Z0-9]*=//'`
    ;;
		--containerrun*)
    	RUN_IN_CONTAINER=true
    ;;
		--containeroptions=*)
    	CONTAINER_OPTIONS=`echo $item | sed 's/[-a-zA-Z0-9]*=//'`
    ;;
		
		
		## SUBMISSION OPTIONS	
		--submit*)
    	SUBMIT=true
    ;;
		--queue=*)
    	BATCH_QUEUE=`echo $item | sed 's/[-a-zA-Z0-9]*=//'`		
    ;;
		--jobwalltime=*)
			JOB_WALLTIME=`echo $item | sed 's/[-a-zA-Z0-9]*=//'`	
		;;
		--jobmemory=*)
			JOB_MEMORY=`echo $item | sed 's/[-a-zA-Z0-9]*=//'`	
		;;
		--jobusergroup=*)
			JOB_USER_GROUP=`echo $item | sed 's/[-a-zA-Z0-9]*=//'`	
			JOB_USER_GROUP_OPTION="#PBS -A $JOB_USER_GROUP"
		;;
		
		
    *)
    # Unknown option
    echo "ERROR: Unknown option ($item)...exit!"
    exit 1
    ;;
	esac
done



#######################################
##         CHECK ARGS
#######################################
if [ "$MOSAIC_FILE" = "" ]; then
	echo "ERROR: Missing or empty input mosaic filename!"
	exit 1				
fi
if [ "$FILELIST_IMGS" = "" ]; then
	echo "ERROR: Missing or empty input restored images filelist!"
	exit 1				
fi
if [ "$FILELIST_RESIDUALS" = "" ]; then
	echo "ERROR: Missing or empty input residual images filelist!"
	exit 1				
fi
if [ "$FILELIST_WEIGHTS" = "" ]; then
	echo "ERROR: Missing or empty input weight images filelist!"
	exit 1				
fi

#FILELIST_IMGS_FULLPATH=`realpath $FILELIST_IMGS`
#FILELIST_RESIDUALS_FULLPATH=`realpath $FILELIST_RESIDUALS`
#FILELIST_WEIGHTS_FULLPATH=`realpath $FILELIST_WEIGHTS`

FILELIST_IMGS_FULLPATH=`readlink -f $FILELIST_IMGS`
FILELIST_RESIDUALS_FULLPATH=`readlink -f $FILELIST_RESIDUALS`
FILELIST_WEIGHTS_FULLPATH=`readlink -f $FILELIST_WEIGHTS`

## Check that filelists have the same number of files
NFILES_IMGS=$(wc -l < "$FILELIST_IMGS")
NFILES_RESIDUALS=$(wc -l < "$FILELIST_RESIDUALS")
NFILES_WEIGHTS=$(wc -l < "$FILELIST_WEIGHTS")
if [ "$NFILES_IMGS" != "$NFILES_RESIDUALS" ] || [ "$NFILES_IMGS" != "$NFILES_WEIGHTS" ] || [ "$NFILES_RESIDUALS" != "$NFILES_WEIGHTS" ]; then
	echo "ERROR: Number of files listed in residual/img/weight filelist differ (it should be the same!)"
	exit 1
fi



#######################################
##     DEFINE & LOAD ENV VARS
#######################################
export BASEDIR="$PWD"


#######################################
##     RUN
#######################################
RUN_ID=$START_ID
echo "Generate $NRUNS runs starting from RUN_ID=$RUN_ID ..."

for ((index=1; index<=$NRUNS; index=$index+1))
do
	## Create job top directory
	JOB_DIR="$BASEDIR/RUN$RUN_ID"

	skymodel_file="skymodel-RUN$RUN_ID.fits"
	ds9_file="ds9-RUN$RUN_ID.reg"
	source_file="sources-RUN$RUN_ID.dat"
	mosaic_parset_file="mosaic-RUN$RUN_ID.parset"
	mosaic_outfile="mosaic-RUN$RUN_ID"
	mosaic_outfile_fits="$mosaic_outfile.fits"
	mosaic_weight_outfile="weight_mosaic-RUN$RUN_ID"
	mosaic_run_script="linmos-RUN$RUN_ID.sh"

	## Define run script
	shfile="Sim-RUN$RUN_ID.sh"
	echo "INFO: Creating sh file $shfile ..."
	(
		echo "#!/bin/bash"
		echo "#PBS -N SimJob$RUN_ID"
		echo "#PBS -j oe"
		echo "#PBS -o $BASEDIR"
    echo "#PBS -l select=1:ncpus=1:mem=$JOB_MEMORY"'GB'
		echo "#PBS -l walltime=$JOB_WALLTIME"
    echo '#PBS -r n'
    echo '#PBS -S /bin/bash'    
    echo '#PBS -p 1'
		echo "$JOB_USER_GROUP_OPTION"

    echo " "
		echo 'echo "INFO: Running on host $HOSTNAME ..."'
		echo " "

    echo 'echo "*************************************************"'
    echo 'echo "****         PREPARE JOB                     ****"'
    echo 'echo "*************************************************"'
		echo "JOBDIR=$JOB_DIR" 
		echo 'echo "INFO: Creating job top directory $JOBDIR ..."'
		echo 'mkdir -p "$JOBDIR"'
	
		echo " "
	
		echo 'echo "INFO: Entering job directory $JOBDIR ..."'
		echo 'cd $JOBDIR'
		
		echo " "	
		   
		if [ "$ENV_FILE" != "" ]; then
			echo 'echo "INFO: Source the software environment ..."'
			echo "source $ENV_FILE"		
		fi
    
		echo " "
	
		echo 'echo "*************************************************"'
    echo 'echo "****         RUN SKYMODEL SIMULATION         ****"'
    echo 'echo "*************************************************"'
		
		echo " "
		echo 'EXE="'"$CASAPATH/bin/casa --nologger --log2term --nogui -c $CAESAR_SCRIPTS_DIR/generate_ps_map.py"'"'
		echo 'EXE_ARGS="'"--no-convolve --mosaic=$MOSAIC_FILE --outfile_model=$JOB_DIR/$skymodel_file --outfile_sources=$JOB_DIR/$source_file --outfile_ds9region=$JOB_DIR/$ds9_file --source_density=$SOURCE_DENSITY --nsources=$NSOURCES --Smin=$SMIN --Smax=$SMAX "'"'
		
		echo " "

		echo 'echo "INFO: Running command $EXE $EXE_ARGS ..."'
		echo '$EXE $EXE_ARGS'
			
		echo " "
		
		echo 'echo "*************************************************"'
    echo 'echo "****        SKYMODEL CONVOLVERS              ****"'
    echo 'echo "*************************************************"'

		echo 'echo "INFO: Running skymodel convolver for all beams ..."'
		echo " "


		## Iterate over filelists provided 
		echo 'WEIGHT_LIST=()'
		echo 'IMG_LIST=()'
   
		echo 'while IFS=$'"'\t'"' read -r residual_file img_file weight_file'
		echo 'do' 

		echo ""

		echo '	## Extract base filename from file given in list'
		echo '	img_file_base=$(basename "$img_file")'
		echo '	img_file_base_noext="${img_file_base%.*}"'
		

		echo '	echo "INFO: Processing restored image $img_file_base_noext in list ..."'
		
		echo ''

		echo '	## Define output file names'
		echo '	outfile_img_casa="sim-$img_file_base_noext'"-RUN$RUN_ID"'"'
		echo '	outfile_img="sim-$img_file_base_noext'"-RUN$RUN_ID.fits"'"'
		echo '	outfile_modelconv="skymodelconv-$img_file_base_noext'"-RUN$RUN_ID.fits"'"'
		echo '	WEIGHT_LIST+=("$weight_file")'
		echo '	IMG_LIST+=("$JOBDIR/$outfile_img_casa")'
		
		echo '	echo "INFO: Set outfile to: $outfile_img ..."'
		
		echo ''

		echo '	## Define exe & args..."'
		echo '	EXE="'"$CASAPATH/bin/casa --nologger --log2term --nogui -c $CAESAR_SCRIPTS_DIR/generate_ps_map.py"'"'
		echo '	EXE_ARGS="' "--model=$JOB_DIR/$skymodel_file"' --residual=$residual_file --img=$img_file --outfile_img=$JOBDIR/$outfile_img --outfile_modelconv=$JOBDIR/$outfile_modelconv"'
			
		echo ''

		echo '	echo "INFO: Running command $EXE $EXE_ARGS ..."'
		echo '	$EXE $EXE_ARGS'

		echo " "
		
		echo "done < <(paste $FILELIST_RESIDUALS_FULLPATH $FILELIST_IMGS_FULLPATH $FILELIST_WEIGHTS_FULLPATH)"
		
		echo " "

		echo " "
		
		echo 'echo "*************************************************"'
    echo 'echo "****        MOSAIC COMPUTING                 ****"'
    echo 'echo "*************************************************"'

		echo 'echo "INFO: Generate linmos parset ..."'
		echo 'WEIGHT_CONCAT_LIST=$(printf ",%s" "${WEIGHT_LIST[@]}") && WEIGHT_CONCAT_LIST=${WEIGHT_CONCAT_LIST:1}'
		echo 'IMG_CONCAT_LIST=$(printf ",%s" "${IMG_LIST[@]}") && IMG_CONCAT_LIST=${IMG_CONCAT_LIST:1}'
		echo 'echo "INFO: weight list: $WEIGHT_CONCAT_LIST"'
		echo 'echo "INFO: image list: $IMG_CONCAT_LIST"'

		echo " "

		##echo 'echo "linmos.weighttype = FromWeightImages"'" > $JOB_DIR/$mosaic_parset_file"
		echo 'echo "linmos.weighttype = Combined"'" > $JOB_DIR/$mosaic_parset_file"
		echo 'echo "linmos.weightstate = Inherent"'" >> $JOB_DIR/$mosaic_parset_file"
		echo 'echo "linmos.names = [$IMG_CONCAT_LIST]"'" >> $JOB_DIR/$mosaic_parset_file"
		echo 'echo "linmos.weights = [$WEIGHT_CONCAT_LIST]"'">> $JOB_DIR/$mosaic_parset_file"
		echo 'echo "linmos.outname = '"$JOB_DIR/$mosaic_outfile"'"'" >> $JOB_DIR/$mosaic_parset_file"
		echo 'echo "linmos.outweight = '"$JOB_DIR/$mosaic_weight_outfile"'"'" >> $JOB_DIR/$mosaic_parset_file"
		echo 'echo "linmos.psfref = 0"'"  >> $JOB_DIR/$mosaic_parset_file"
		echo 'echo "linmos.cutoff = 0.2"'"  >> $JOB_DIR/$mosaic_parset_file"

		echo " "

		echo 'echo "INFO: Generate linmos runscript ..."'
		echo 'echo "#!/bin/sh"'" > $JOB_DIR/$mosaic_run_script"
		echo 'echo "mpirun linmos-mpi -c "'"$JOB_DIR/$mosaic_parset_file >> $JOB_DIR/$mosaic_run_script"
		echo "chmod +x $JOB_DIR/$mosaic_run_script"
		echo " "

		echo 'echo "INFO: Running linmos with all beams ..."'
		if [ "$RUN_IN_CONTAINER" = true ] ; then
			echo 'EXE="singularity exec '"$CONTAINER_OPTIONS $CONTAINER_IMG $JOB_DIR/$mosaic_run_script"'"'
		else
			echo 'EXE="'"$JOB_DIR/$mosaic_run_script"'"'
		fi
		echo '$EXE'

		echo " "

		echo 'echo "INFO: Making mosaic fits image ..."'
		##echo "casa --nologger --log2term --nogui -c 'exportfits(imagename="'"$JOBDIR/$mosaic_outfile",fitsimage="$JOBDIR/$mosaic_outfile.fits"'")'"
		echo "casa --nologger --log2term --nogui -c 'exportfits(overwrite=True,imagename="'"'"$JOB_DIR/$mosaic_outfile"'"'",fitsimage="'"'"$JOB_DIR/$mosaic_outfile.fits"'")'"'"


    echo 'echo "*** END RUN ***"'

	) > $shfile
	chmod +x $shfile

	####mv $shfile $CURRENTJOBDIR
	(( RUN_ID= $RUN_ID + 1 ))
	
	
	# Submits the job to batch system
	if [ "$SUBMIT" = true ] ; then
		echo "INFO: Submitting script $shfile to QUEUE $BATCH_QUEUE ..."
		qsub -q $BATCH_QUEUE $BASEDIR/$shfile
	fi

done

echo "*** END SUBMISSION ***"


