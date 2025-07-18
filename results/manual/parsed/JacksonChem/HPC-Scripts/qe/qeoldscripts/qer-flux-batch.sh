#!/bin/bash
#FLUX: --job-name=grated-caramel-2853
#FLUX: --urgency=16

NPROC=$1
QHR=$2
QMIN=$3
FNAME=`echo $4 | awk -F. '{print $1}'`
JTYPE=$5
CURDIR=$(pwd)
NODE=1
QTYPE=$6
MEM_GB=100
WRKDIR=$(pwd)
SUBDIR=$(pwd)                         #Location for submission scripts
SUBFILE=${FNAME}qe.sh
LOGDIR=/home/$(whoami)               #Location for job logging files, change if desired
if  [[ ! -d ${SUBDIR} ]]; then       #Check if SUBDIR exists, create if not
        mkdir ${SUBDIR}
fi
SCRDIR=/scratch/`whoami`/pdft/${FNAME}
if  [[ ! -d ${SCRDIR} ]]; then       #Check if SCRDIR exists, create if not
        mkdir -p ${SCRDIR}
fi
	if [[ "$#" -lt "1" ]]; then
		echo "Usage:" $0 "#procs #hours #mins file.com Jobtype(s:scf.in n:nscf.in b:bands p:PDOS a:snbp c:compress e:spin) Node:(Default-general b2:bigmem2 b4:bigmem4 a:amd g:2xgpu)"
		exit 10
	elif [[ "$#" -lt "4" ]]; then
		echo "Not all parameters are given"
		exit 20
	fi
	if [[ ! -e $4 ]]; then
	#if [[ ! -e "$FNAME".scf.in ]] || [[ ! -e "$FNAME".nscf.in ]] || [[! -e "$FNAME".band.in]] || [[! -e "$FNAME".pdos.in]]; then
		echo "Input file was not found"
		exit 100
	fi
        if [[ "$QTYPE" = "rb2" || "$QTYPE" = "b2" || "$QTYPE" = "b4" || "$QTYPE" = "gpu" ]]; then
                NMAX=48
                if [[ "$QTYPE" = "b2" || "$QTYPE" = "rb2" ]]; then
                        MEMMAX=384
                fi
                if [[ "$QTYPE" = "b4" ]]; then
                        MEMMAX=768
                fi
                if [[ "$QTYPE" = "gpu" ]]; then
			echo "This script is not setup for GPU calculations- please resubmit with another queue"
			exit 30
                fi
        elif [[ "$QTYPE" = "a" ]]; then
                NMAX=128
                MEMMAX=256
        else
                NMAX=48
                MEMMAX=192
        fi
	if [[ $NPROC -gt $NMAX ]]; then
		echo "You have requested more processors than is available on a node"
		echo "Multi-node calculations are not supported by this submission script"
		exit 40
	fi
	if [[ $MEM_GB -gt $MEMMAX ]]; then
		echo "You have requested more memory than is available on a node"
		echo "Multi-node calculations are not supported by this submission script"
		exit 50
	fi
	MEM_MB=$((${MEM_GB}*1024)) #Convert to MB
	MEM_PER_PROC=$((${MEM_MB}/${NPROC})) #Calculate Memory per processor
	echo "#!/bin/bash -l" > ${SUBDIR}/${SUBFILE}
	echo "#SBATCH --job-name=${FNAME}.qe" >> ${SUBDIR}/${SUBFILE}          # job name
	echo "#SBATCH --nodes=${NODE}" >> ${SUBDIR}/${SUBFILE}                 # node(s) required for job
	echo "#SBATCH --ntasks=${NPROC}" >> ${SUBDIR}/${SUBFILE}               # number of tasks (Cores) across all nodes
	echo "#SBATCH --cpus-per-task=1" >> ${SUBDIR}/${SUBFILE}               # 1 task per CPU, prevent multiple processes running
	echo "#SBATCH --mem-per-cpu=${MEM_PER_PROC}" >> ${SUBDIR}/${SUBFILE}   # Memory for each processor in MB
	echo "#SBATCH --error=${SUBDIR}/${FNAME}.e%j" >> ${SUBDIR}/${SUBFILE}            # Error file
	echo "#SBATCH --time=${QHR}:${QMIN}:00" >> ${SUBDIR}/${SUBFILE}        # Run time (D-HH:MM:SS)
	echo "#SBATCH --output=/dev/null" >> ${SUBDIR}/${SUBFILE}              # Output file
	if [[ "$QTYPE" = "b2" ]]; then
		echo "#SBATCH --partition=bigmem2" >> ${SUBDIR}/${SUBFILE}
	elif [[ "$QTYPE" = "rb2" ]]; then
                echo "#SBATCH --partition=ezm0048_bg2" >> ${SUBDIR}/${SUBFILE}
	elif [[ "$QTYPE" = "b4" ]]; then
		echo "#SBATCH --partition=bigmem4" >> ${SUBDIR}/${SUBFILE}
	elif [[ "$QTYPE" = "a" ]]; then
		echo "#SBATCH --partition=amd" >> ${SUBDIR}/${SUBFILE}
	elif [[ "$QTYPE" = "gpu" ]]; then
		echo "#SBATCH --partition=gpu2" >> ${SUBDIR}/${SUBFILE}
	elif [[ "$QTYPE" = "r" ]]; then
		echo "#SBATCH --partition=ezm0048_std" >> ${SUBDIR}/${SUBFILE}
	else
		echo "#SBATCH --partition=general" >> ${SUBDIR}/${SUBFILE}
	fi
        echo "#SBATCH --mail-user=$(whoami)@auburn.edu" >> ${SUBDIR}/${SUBFILE}              # Provide user's email address
        ## Email settings- only enable one of these options
        echo "#SBATCH --mail-type=NONE" >> ${SUBDIR}/${SUBFILE}                              # Do not email for anything
        #echo "#SBATCH --mail-type=ALL" >> ${SUBDIR}/${SUBFILE}                              # Emails for Begin, End, Fail, Invalid_depend, Requeue, and Stage_out
        #echo "#SBATCH --mail-type=TIME_LIMIT_90,END,FAIL,REQUEUE" >> ${SUBDIR}/${SUBFILE}   # Email at 90% Queue time, Job End, Job Fail, and Requeue
        #echo "#SBATCH --requeue" >> ${SUBDIR}/${SUBFILE}                                     # Requeue jobs when preempted 
        ## Option for logging job submission ##
        #echo -e "echo \"\`date\`: Job ID: \${SLURM_JOB_ID} Path: ${WRKDIR}:${FNAME} \" >> ${LOGDIR}/qesub.log" >> ${SUBDIR}/${SUBFILE}
	echo -e "CURDIR=${CURDIR}" >> ${SUBDIR}/${SUBFILE}
	echo -e "SCRDIR=${SCRDIR}" >> ${SUBDIR}/${SUBFILE}
	echo -e "FNAME=${FNAME}" >> ${SUBDIR}/${SUBFILE}
	echo "cd $CURDIR" >> ${SUBDIR}/${SUBFILE}
	echo 'module load espresso/intel/6.8' >> ${SUBDIR}/${SUBFILE}
	echo -e "cd \${SCRDIR}" >> ${SUBDIR}/${SUBFILE}
	if [[ "$JTYPE" = "s" ]]; then
		echo -e "sed -ir s/prefix=.*/prefix=\'\${FNAME}\'/ \${FNAME}.scf.in" >> ${SUBDIR}/${SUBFILE}
		echo -e "cp \${CURDIR}/\${FNAME}.scf.in \${SCRDIR}/\${FNAME}.scf.in" >> ${SUBDIR}/${SUBFILE}
		echo "mpirun -n ${NPROC} /tools/espresso-6.8/bin/pw.x -inp \${SCRDIR}/\${FNAME}.scf.in > \${CURDIR}/\${FNAME}.scf.out" >> ${SUBDIR}/${SUBFILE}
	elif [[ "$JTYPE" = "n" ]]; then
		echo -e "sed -ir s/prefix=.*/prefix=\'\${FNAME}\'/ \${FNAME}.nscf.in" >> ${SUBDIR}/${SUBFILE}
		echo -e "cp \${CURDIR}/\${FNAME}.scf.in \${SCRDIR}/\${FNAME}.nscf.in" >> ${SUBDIR}/${SUBFILE}
		echo "mpirun -n ${NPROC} /tools/espresso-6.8/bin/pw.x -inp \${SCRDIR}/\${FNAME}.nscf.in > \${CURDIR}/\${FNAME}.nscf.out" >> ${SUBDIR}/${SUBFILE}
	elif [[ "$JTYPE" = "b" ]]; then
		echo -e "sed -ir s/prefix=.*/prefix=\'\${FNAME}\'/ \${FNAME}.bands.in" >> ${SUBDIR}/${SUBFILE}
		echo -e "cp \${CURDIR}/\${FNAME}.bands.in \${SCRDIR}/\${FNAME}.bands.in" >> ${SUBDIR}/${SUBFILE}
		echo -e "mpirun -n ${NPROC} /tools/espresso-6.8/bin/bands.x -inp \${SCRDIR}/\${FNAME}.bands.in > \${CURDIR}/\${FNAME}.bands.out" >> ${SUBDIR}/${SUBFILE}
	elif [[ "$JTYPE" = "p" ]]; then
		echo -e "cp \${CURDIR}/\${FNAME}.pdos.in \${SCRDIR}/\${FNAME}.pdos.in" >> ${SUBDIR}/${SUBFILE}
		echo -e "mpirun -n ${NPROC} /tools/espresso-6.8/bin/projwfc.x -inp \${SCRDIR}/\${FNAME}.pdos.in > \${CURDIR}/\${FNAME}.pdos.out" >> ${SUBDIR}/${SUBFILE}
	elif [[ "$JTYPE" = "e" ]]; then
		echo -e "cp \${CURDIR}/\${FNAME}.pdos.in \${SCRDIR}/\${FNAME}.up.bands.in" >> ${SUBDIR}/${SUBFILE}
		echo -e "cp \${CURDIR}/\${FNAME}.pdos.in \${SCRDIR}/\${FNAME}.dn.bands.in" >> ${SUBDIR}/${SUBFILE}
		echo -e "cp \${CURDIR}/\${FNAME}.up.bands.in \${SCRDIR}/\${FNAME}.up.bands.in" >> ${SUBDIR}/${SUBFILE}
		echo -e "cp \${CURDIR}/\${FNAME}.dn.bands.in \${SCRDIR}/\${FNAME}.dn.bands.in" >> ${SUBDIR}/${SUBFILE}
		echo -e "mpirun -n ${NPROC} /tools/espresso-6.8/bin/bands.x -inp \${SCRDIR}/\${FNAME}.up.bands.in > \${CURDIR}/\${FNAME}.up.bands.out" >> ${SUBDIR}/${SUBFILE}
		echo -e "mpirun -n ${NPROC} /tools/espresso-6.8/bin/bands.x -inp \${SCRDIR}/\${FNAME}.dn.bands.in > \${CURDIR}/\${FNAME}.dn.bands.out" >> ${SUBDIR}/${SUBFILE}
	else
		echo "No job type selected"
		exit 40
	fi
	## Option for logging job completion ##
	#echo -e "echo \"\`date\`: Job ID: \${SLURM_JOB_ID} Path: ${WRKDIR}:${FNAME} \" >> ${LOGDIR}/qedone.log" >> ${SUBDIR}/${SUBFILE}
	## Cleaning function for error files
	echo -e "if [[ ! -s \${SUBDIR}/\${FNAME}.e\${SLURM_JOB_ID} ]]; then " >> ${SUBDIR}/${SUBFILE}
	echo "  rm - f \${SUBDIR}/\${FNAME}.e\${SLURM_JOB_ID}" >> ${SUBDIR}/${SUBFILE}
	echo "else" >> ${SUBDIR}/${SUBFILE}
	echo "  mv \${SUBDIR}/\${FNAME}.e\${SLURM_JOB_ID} \${CURDIR}/." >> ${SUBDIR}/${SUBFILE}
	echo "fi" >> ${SUBDIR}/${SUBFILE}
	## Cleaning function for submission script ##
	#echo "function cleansub { rm -f $(echo ${SUBDIR}/${SUBFILE}); }" >> ${SUBDIR}/${SUBFILE}
	#echo "trap cleansub EXIT" >> ${SUBDIR}/${SUBFILE}
	echo 'exit 0' >> ${SUBDIR}/${SUBFILE}
