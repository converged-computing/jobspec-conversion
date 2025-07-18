#!/bin/bash
#FLUX: --job-name=bloated-lettuce-5816
#FLUX: --urgency=16

if [ "$#" -gt 2  -o  "$#" -eq 0 ]; then
	echo "********************************************************************"
	echo "*                        Matbatch version 0.1                      *"
	echo "********************************************************************"
	echo "The 'matbatch' script submits Matlab batch jobs to the DCSR cluster using SLURM."
	echo ""
	echo "Usage is:"
	echo "         matbatch <input_file.m> [<output_file.log>]"
	echo ""
	echo "If only input_file.m is provided, then input_file.log will be created."
	echo ""
	echo "Spaces in the filename or directory name may cause failure."
	echo ""
else
	# Stem and extension of file
	filestem=`echo $1 | cut -f1 -d.`
	extension=`echo $1 | cut -f2 -d.`
	# Test if file exist
	if [ ! -r $1 ]; then
		echo ""
		echo "File does not exist"
		echo ""
	elif [ $extension != m ]; then
		echo ""
		echo "Invalid input file, must be an m-file"
		echo ""
	else
		# Direct output, conditional on number of arguments
		if [ "$#" -eq 1 ]; then
			output=$filestem.log
		else
			output=$2
		fi
		# Use user-defined 'TMPDIR' if possible; else, use /work/tmr17
		if [[ -n $TMPDIR ]]; then
			pathy=$TMPDIR
		else
			pathy=/work/tmr17
		fi
		# Tempfile for the script
		shell=`mktemp $pathy/shell.XXXXXX` || exit 1
		chmod 700 $shell
		# Create script
		echo "#!/bin/bash"                        >> $shell
		# workaround for "GLIBC_2.0 not being defined" error on 2.4 kernels
		checkkernelversion=`uname -r | cut -f1-2 -d.`
		if [ "$checkkernelversion" == "2.4" ];
		then
			echo 'export LD_ASSUME_KERNEL=2.4.1'  >> $shell
		fi
		# SLURM metacommands
		echo "#SBATCH --job-name=matbatch"        >> $shell
		echo "#SBATCH --output=$output"           >> $shell
		echo "#SBATCH --mail-type=ALL"            >> $shell
		echo "#SBATCH --mail-user=email@address.com" >> $shell
		echo "#SBATCH --array=1-100"              >> $shell
		echo "#SBATCH --mem-per-cpu=50G"          >> $shell
        echo "#SBATCH --partition=scavenger,econ" >> $shell
		# echo "#SBATCH --mincpus=4"                >> $shell
		# echo "#SBATCH --ntasks-per-node=4"        >> $shell
		# echo "#SBATCH --cpus-per-task=4"          >> $shell
		echo "pwd"                                >> $shell
		echo "date"                               >> $shell
		echo "matlab -singleCompThread -nojvm -nodisplay -r \"$filestem;quit\"" >> $shell
		sbatch $shell
	fi
fi
