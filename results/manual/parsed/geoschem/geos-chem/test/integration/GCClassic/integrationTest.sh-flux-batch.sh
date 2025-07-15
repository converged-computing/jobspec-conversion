#!/bin/bash
#FLUX: --job-name=expressive-car-2449
#FLUX: --priority=16

this="$(basename ${0})"
usage="Usage: ${this} -d root-dir -t compile|all [-e env-file] [-h] [-n] [-q]"
quick="NO"
bootStrap="YES"
thisDir=$(pwd -P)
cd "${thisDir}"
. "${thisDir}/../../shared/commonFunctionsForTests.sh"
validArgs=$(getopt --options d:e:hnqs:t: \
  --long directory:,env-file:,help,no-bootstrap,quick,tests-to-run: -- "$@")
if [[ $? -ne 0 ]]; then
    exit 1;
fi
eval set -- "${validArgs}"
while [ : ]; do
    case "${1}" in
        # -d or --directory specifies the root folder for tests
        -d | --directory)
            itRoot="${2}"
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
	# -n or --no-bootstrap prevents bootstrapping missing variables in
        # restart files (i.e. do not change EFYO -> CYS in HEMCO_Config.rc)
	-n | --no-bootstrap)
            bootStrap="NO"
	    shift
            ;;
	# -q or --quick runs a quick set of integration tests (for testing)
	-q | --quick)
            quick="YES"
            shift
            ;;
	# -t or --tests-to-run specifies the type of tests to run
	-t | --tests-to-run)
            testsToRun="${2^^}"
            shift 2
            ;;
	--) shift;
            break
            ;;
    esac
done
site=$(get_site_name)
if [[ "X${itRoot}" == "X" ]]; then
    echo "ERROR: The integration test root directory has not been specified!"
    echo "${usage}"
    exit 1
fi
if [[ "X${testsToRun}" == "X" ]]; then
    echo "ERROR: You must specify the test type: compile|all"
    echo "${usage}"
    exit 1
fi
if [[ "X${testsToRun}" != "XCOMPILE" && "X${testsToRun}" != "XALL" ]]; then
    echo "ERROR: Invalid selction for tests-to-run, must be: compile|all"
    echo "${usage}"
    exit 1
fi
if [[ "X${testsToRun}" == "XALL" ]]; then
    # Use the default environment file for Cannon if not specified
    if [[ "X${site}" == "XCANNON" && "X${envFile}" == "X" ]]; then
	envFile=$(get_default_gcc_env_file)
    fi
    # Get the sed command that will replace the partition name
    sedPartitionCmd=$(get_sed_partition_cmd_from_site "${site}")
fi
itRoot=$(absolute_path "${itRoot}")
if [[ "$(absolute_path ${thisDir})" =~ "${itRoot}" ]]; then
    echo "ERROR: You cannot run integration tests in the source code directory!"
    exit 1
fi
./integrationTestCreate.sh "${itRoot}" "${envFile}" "${testsToRun}" "${quick}"
if [[ $? -ne 0 ]]; then
   echo "ERROR: Could not create integration test run directories!"
   exit 1
fi
if [[ -d "${itRoot}" ]]; then
    cd "${itRoot}"
else
    echo "ERROR: ${itRoot} is not a valid directory!  Exiting..."
    exit 1
fi
logsDir="${itRoot}/${LOGS_DIR}"
scriptsDir="${itRoot}/${SCRIPTS_DIR}"
rundirsDir="${itRoot}/${RUNDIRS_DIR}"
if [[ "X${testsToRun}" == "XALL" ]]; then
   gcc_enable_or_disable_bootstrap "${bootStrap}" "${rundirsDir}"
fi
cd "${logsDir}"
if [[ "X${testsToRun}" == "XCOMPILE" ]]; then
    #-------------------------------------------------------------------------
    # Compilation-only tests (scheduler is not used)
    #-------------------------------------------------------------------------
    echo ""
    echo "Compiliation tests are running..."
    ${scriptsDir}/integrationTestCompile.sh "${quick}"
elif [[ "X${testsToRun}" == "XALL" && "X${site}" == "XCANNON" ]]; then
    #-------------------------------------------------------------------------
    # Compilation & execution tests on Harvard Cannon (via SLURM)
    #-------------------------------------------------------------------------
    # Remove LSF #BSUB tags
    sed_ie '/#BSUB -q REQUESTED_PARTITION/d' "${scriptsDir}/integrationTestCompile.sh"
    sed_ie '/#BSUB -n 8/d'                   "${scriptsDir}/integrationTestCompile.sh"
    sed_ie '/#BSUB -W 0:30/d'                "${scriptsDir}/integrationTestCompile.sh"
    sed_ie '/#BSUB -o lsf-%J.txt/d'          "${scriptsDir}/integrationTestCompile.sh"
    sed_ie \
      '/#BSUB -R "rusage\[mem=8GB\] span\[ptile=1\] select\[mem < 1TB\]"/d' \
      "${scriptsDir}/integrationTestCompile.sh"
    sed_ie \
      "/#BSUB -a 'docker(registry\.gsc\.wustl\.edu\/sleong\/esm\:intel\-2021\.1\.2)'/d" \
      "${scriptsDir}/integrationTestCompile.sh"
    sed_ie '/#BSUB -q REQUESTED_PARTITION/d' "${scriptsDir}/integrationTestExecute.sh"
    sed_ie '/#BSUB -n 24/d'                  "${scriptsDir}/integrationTestExecute.sh"
    sed_ie '/#BSUB -W 6:00/d'                "${scriptsDir}/integrationTestExecute.sh"
    sed_ie '/#BSUB -o lsf-%J.txt/d'          "${scriptsDir}/integrationTestExecute.sh"
    sed_ie \
      '/#BSUB -R "rusage\[mem=90GB\] span\[ptile=1\] select\[mem < 2TB\]"/d' \
      "${scriptsDir}/integrationTestExecute.sh"
    sed_ie \
      "/#BSUB -a 'docker(registry\.gsc\.wustl\.edu\/sleong\/esm\:intel\-2021\.1\.2)'/d" \
      "${scriptsDir}/integrationTestExecute.sh"
    # Replace "REQUESTED_PARTITION" with the partition name
    sed_ie "${sedPartitionCmd}" "${scriptsDir}/integrationTestCompile.sh"
    sed_ie "${sedPartitionCmd}" "${scriptsDir}/integrationTestExecute.sh"
    # Submit compilation tests script
    output=$(sbatch ${scriptsDir}/integrationTestCompile.sh "${quick}")
    output=($output)
    cmpId=${output[3]}
    # Submit execution tests script as a job dependency
    output=$(sbatch --dependency=afterok:${cmpId} ${scriptsDir}/integrationTestExecute.sh)
    output=($output)
    exeId=${output[3]}
    # Echo SLURM jobIDs
    echo ""
    echo "Compilation tests submitted as SLURM job ${cmpId}"
    echo "Execution   tests submitted as SLURM job ${exeId}"
elif [[ "X${testsToRun}" == "XALL" && "X${site}" == "XCOMPUTE1" ]]; then
    #-------------------------------------------------------------------------
    # Compilation and execution tests on WashU Compute1 (via LSF)
    #-------------------------------------------------------------------------
    # Remove SLURM #SBATCH tags
    sed_ie '/#SBATCH -c 8/d'                   "${scriptsDir}/integrationTestCompile.sh"
    sed_ie '/#SBATCH -N 1/d'                   "${scriptsDir}/integrationTestCompile.sh"
    sed_ie '/#SBATCH -t 0-0:30/d'              "${scriptsDir}/integrationTestCompile.sh"
    sed_ie '/#SBATCH -p REQUESTED_PARTITION/d' "${scriptsDir}/integrationTestCompile.sh"
    sed_ie '/#SBATCH --mem=8000/d'             "${scriptsDir}/integrationTestCompile.sh"
    sed_ie '/#SBATCH -p REQUESTED_PARTITION/d' "${scriptsDir}/integrationTestCompile.sh"
    sed_ie '/#SBATCH --mail-type=END/d'        "${scriptsDir}/integrationTestCompile.sh"
    sed_ie '/#SBATCH -c 24/d'                  "${scriptsDir}/integrationTestExecute.sh"
    sed_ie '/#SBATCH -N 1/d'                   "${scriptsDir}/integrationTestExecute.sh"
    sed_ie '/#SBATCH -t 0-6:00/d'              "${scriptsDir}/integrationTestExecute.sh"
    sed_ie '/#SBATCH -p REQUESTED_PARTITION/d' "${scriptsDir}/integrationTestExecute.sh"
    sed_ie '/#SBATCH --mem=90000/d'            "${scriptsDir}/integrationTestExecute.sh"
    sed_ie '/#SBATCH --mail-type=END/d'        "${scriptsDir}/integrationTestExecute.sh"
    # Replace "REQUESTED_PARTITION" with the partition name
    sed_ie "${sedPartitionCmd}" "${scriptsDir}/integrationTestCompile.sh"
    sed_ie "${sedPartitionCmd}" "${scriptsDir}/integrationTestExecute.sh"
    # Submit compilation tests script
    output=$(bsub ${scriptsDir}/integrationTestCompile.sh "${quick}")
    output=($output)
    cmpId=${output[1]}
    cmpId=${cmpId/<}
    cmpId=${cmpId/>}
    # Submit execution tests script as a job dependency
    output=$(bsub -w "exit(${cmpId},0)" ${scriptsDir}/integrationTestExecute.sh)
    output=($output)
    exeId=${output[1]}
    exeId=${exeId/<}
    exeId=${exeId/>}
    echo ""
    echo "Compilation tests submitted as LSF job ${cmpId}"
    echo "Execution   tests submitted as LSF job ${exeId}"
else
    #-------------------------------------------------------------------------
    # Exit with error
    #-------------------------------------------------------------------------
    echo ""
    echo "ERROR! Invalid choice of arguments!"
    echo "${usage}"
    exit 1
fi
cd "${thisDir}"
unset cmpId
unset envFile
unset exeId
unset itRoot
unset logsDir
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
