#!/bin/bash
#FLUX: --job-name=pusheena-soup-4874
#FLUX: --urgency=16

this="$(basename ${0})"
usage="Usage: ${this} -d root-dir -e env-file [-h] [-p partition] [-q] [-s scheduler]"
ptRoot="none"
envFile="none"
scheduler="none"
sedCmd="none"
quick="no"
validArgs=$(getopt --options d:e:hp:qs: \
  --long directory:,env-file:,help,partition:,quick,scheduler: -- "$@")
if [[ $? -ne 0 ]]; then
    exit 1;
fi
eval set -- "${validArgs}"
while [ : ]; do
    case "${1}" in
	# -d or --directory specifies the root folder for tests
	-d | --directory)
	    ptRoot="${2}"
            shift 2
            ;;
	# -e or --env-file specifies the environment file
	-e | --env-file)
	    envFile="${2}"
            shift 2
            ;;
	# -h or --help prints a help message
	-h | --help)
            echo "$usage"
            exit 1
            ;;
	# -p or --partition replaces REQUESTED_PARTITON w/ the user's choice
	-p | --partition)
	    sedCmd="s/REQUESTED_PARTITION/${2}/"
	    shift 2
	    ;;
	# -q or --quick runs a quick set of parallelization tests (for testing)
	-q | --quick)
	    quick="yes"
            shift
	    ;;
	# -s or --scheduler selects the scheduler to use
	-s | --scheduler)
	    scheduler="${2^^}"
            shift 2
            ;;
	--) shift;
            break
            ;;
    esac
done
if [[ "x${ptRoot}" == "xnone" ]]; then
    echo "ERROR: The parallelization test root directory has not been specified!"
    echo "${usage}"
    exit 1
fi
if [[ "x${envFile}" == "xnone" ]]; then
    echo "ERROR: The enviroment file (module loads) has not been specified!"
    echo "${usage}"
    exit 1
fi
if [[ "x${scheduler}" == "xSLURM" && "x${sedCmd}" == "xnone" ]]; then
    echo "ERROR: You must specify a partition for SLURM."
    echo "${usage}"
    exit 1
fi
if [[ "x${scheduler}" == "xLSF" && "x${sedCmd}" == "xnone" ]]; then
    echo "ERROR: You must specify a partition for LSF."
    echo "${usage}"
    exit 1
fi
thisDir=$(pwd -P)
if [[ -f "../../shared/commonFunctionsForTests.sh" ]]; then
    . "${thisDir}/../../shared/commonFunctionsForTests.sh"
elif [[ -f "${thisDir}/commonFunctionsForTests.sh" ]]; then
    . "${thisDir}/commonFunctionsForTests.sh"
fi
ptRoot=$(absolute_path "${ptRoot}")
./parallelTestCreate.sh "${ptRoot}" "${envFile}" "${quick}"
if [[ $? -ne 0 ]]; then
   echo "ERROR: Could not create parallelization test run directories!"
   exit 1
fi
if [[ -d ${ptRoot} ]]; then
    cd "${ptRoot}"
else
    echo "ERROR: ${ptRoot} is not a valid directory!  Exiting..."
    exit 1
fi
logsDir="${ptRoot}/${LOGS_DIR}"
scriptsDir="${ptRoot}/${SCRIPTS_DIR}"
cd "${logsDir}"
if [[ "x${scheduler}" == "xSLURM" ]]; then
    #-------------------------------------------------------------------------
    # Parallelization tests will run via SLURM
    #-------------------------------------------------------------------------
    # Remove LSF #BSUB tags
    sed_ie '/#BSUB -q REQUESTED_PARTITION/d' "${scriptsDir}/parallelTestCompile.sh"
    sed_ie '/#BSUB -n 8/d'                   "${scriptsDir}/parallelTestCompile.sh"
    sed_ie '/#BSUB -W 0:30/d'                "${scriptsDir}/parallelTestCompile.sh"
    sed_ie '/#BSUB -o lsf-%J.txt/d'          "${scriptsDir}/parallelTestCompile.sh"
    sed_ie \
	'/#BSUB -R "rusage\[mem=8GB\] span\[ptile=1\] select\[mem < 1TB\]"/d' \
	"${scriptsDir}/parallelTestCompile.sh"
    sed_ie \
	"/#BSUB -a 'docker(registry\.gsc\.wustl\.edu\/sleong\/esm\:intel\-2021\.1\.2)'/d" \
	"${scriptsDir}/parallelTestCompile.sh"
    sed_ie '/#BSUB -q REQUESTED_PARTITION/d' "${scriptsDir}/parallelTestExecute.sh"
    sed_ie '/#BSUB -n 24/d'                  "${scriptsDir}/parallelTestExecute.sh"
    sed_ie '/#BSUB -W 6:00/d'                "${scriptsDir}/parallelTestExecute.sh"
    sed_ie '/#BSUB -o lsf-%J.txt/d'          "${scriptsDir}/parallelTestExecute.sh"
    sed_ie \
	'/#BSUB -R "rusage\[mem=90GB\] span\[ptile=1\] select\[mem < 2TB\]"/d' \
	"${scriptsDir}/parallelTestExecute.sh"
    sed_ie \
	"/#BSUB -a 'docker(registry\.gsc\.wustl\.edu\/sleong\/esm\:intel\-2021\.1\.2)'/d" \
	"${scriptsDir}/parallelTestExecute.sh"
    # Replace "REQUESTED_PARTITION" with the partition name
    sed_ie "${sedCmd}" "${scriptsDir}/parallelTestCompile.sh"
    sed_ie "${sedCmd}" "${scriptsDir}/parallelTestExecute.sh"
    # Submit compilation tests script
    output=$(sbatch ${scriptsDir}/parallelTestCompile.sh)
    output=($output)
    cmpId=${output[3]}
    # Submit execution tests script as a job dependency
    output=$(sbatch --dependency=afterok:${cmpId} ${scriptsDir}/parallelTestExecute.sh)
    output=($output)
    exeId=${output[3]}
    echo ""
    echo "Compilation tests submitted as SLURM job ${cmpId}"
    echo "Execution   tests submitted as SLURM job ${exeId}"
elif [[ "x${scheduler}" == "xLSF" ]]; then
    #-------------------------------------------------------------------------
    # Parallelization tests will run via LSF
    #-------------------------------------------------------------------------
    # Remove SLURM #SBATCH tags
    sed_ie '/#SBATCH -c 8/d'                   "${scriptsDir}/parallelTestCompile.sh"
    sed_ie '/#SBATCH -N 1/d'                   "${scriptsDir}/parallelTestCompile.sh"
    sed_ie '/#SBATCH -t 0-0:30/d'              "${scriptsDir}/parallelTestCompile.sh"
    sed_ie '/#SBATCH -p REQUESTED_PARTITION/d' "${scriptsDir}/parallelTestCompile.sh"
    sed_ie '/#SBATCH --mem=8000/d'             "${scriptsDir}/parallelTestCompile.sh"
    sed_ie '/#SBATCH -p REQUESTED_PARTITION/d' "${scriptsDir}/parallelTestCompile.sh"
    sed_ie '/#SBATCH --mail-type=END/d'        "${scriptsDir}/parallelTestCompile.sh"
    sed_ie '/#SBATCH -c 24/d'                  "${scriptsDir}/parallelTestExecute.sh"
    sed_ie '/#SBATCH -N 1/d'                   "${scriptsDir}/parallelTestExecute.sh"
    sed_ie '/#SBATCH -t 0-6:00/d'              "${scriptsDir}/parallelTestExecute.sh"
    sed_ie '/#SBATCH -p REQUESTED_PARTITION/d' "${scriptsDir}/parallelTestExecute.sh"
    sed_ie '/#SBATCH --mem=90000/d'            "${scriptsDir}/parallelTestExecute.sh"
    sed_ie '/#SBATCH --mail-type=END/d'        "${scriptsDir}/parallelTestExecute.sh"
    # Replace "REQUESTED_PARTITION" with the partition name
    sed_ie "${sedCmd}" "${scriptsDir}/parallelTestCompile.sh"
    sed_ie "${sedCmd}" "${scriptsDir}/parallelTestExecute.sh"
    # Submit compilation tests script
    output=$(bsub $scriptsDir}/parallelTestCompile.sh)
    output=($output)
    cmpId=${output[1]}
    cmpId=${cmpId/<}
    cmpId=${cmpId/>}
    # Submit execution tests script as a job dependency
    output=$(bsub -w "exit(${cmpId},0)" ${scriptsDir}/parallelTestExecute.sh)
    output=($output)
    exeId=${output[1]}
    exeId=${exeId/<}
    exeId=${exeId/>}
else
    #-------------------------------------------------------------------------
    # Parallelization tests will run interactively
    #-------------------------------------------------------------------------
    # Run compilation tests
    echo ""
    echo "Compiliation tests are running..."
    ${scriptsDir}/parallelTestCompile.sh &
fi
cd "${thisDir}"
unset cmpId
unset envFile
unset exeId
unset logsDir
unset ptRoot
unset quick
unset output
unset scheduler
unset scriptsDir
unset thisDir
unset FILL
unset SEP_MAJOR
unset SEP_MINOR
unset CMP_PASS_STR
unset CMP_FAIL_STR
unset EXE_PASS_STR
unset EXE_FAIL_STR
