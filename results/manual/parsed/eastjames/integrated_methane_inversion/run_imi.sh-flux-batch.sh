#!/bin/bash
#FLUX: --job-name=lovable-nalgas-1615
#FLUX: --urgency=16

export PYTHONPATH='${PYTHONPATH}:${InversionPath}'

module load python
source src/utilities/common.sh
source src/components/setup_component/setup.sh
source src/components/template_component/template.sh
source src/components/statevector_component/statevector.sh
source src/components/preview_component/preview.sh
source src/components/spinup_component/spinup.sh
source src/components/jacobian_component/jacobian.sh
source src/components/inversion_component/inversion.sh
source src/components/posterior_component/posterior.sh
source src/components/kalman_component/kalman.sh
trap 'imi_failed $LINENO' ERR
start_time=$(date)
setup_start=$(date +%s)
printf "\n=== PARSING CONFIG FILE (run_imi.sh) ===\n"
if [[ $# == 1 ]] ; then
    ConfigFile=$1
else
    ConfigFile=config.yml
fi
source src/utilities/parse_yaml.sh
eval $(parse_yaml ${ConfigFile})
if ! "$isAWS"; then
    # Activate Conda environment
    printf "\nActivating conda environment: ${CondaEnv}\n"
    eval "$(conda shell.bash hook)"
    conda activate $CondaEnv
    # Load environment for compiling and running GEOS-Chem
    if [ ! -f "${GEOSChemEnv}" ]; then
	printf "\nGEOS-Chem environment file ${GEOSChemEnv} does not exist!"
	printf "\nIMI $RunName Aborted\n"
	exit 1
    else
	printf "\nLoading GEOS-Chem environment: ${GEOSChemEnv}\n"
        source ${GEOSChemEnv}
    fi
fi
echo JDE HERE 1
python src/utilities/sanitize_input_yaml.py $ConfigFile || imi_failed
RunDirs="${OutputPath}/${RunName}"
if "$SafeMode"; then
    # Check if directories exist before creating them
    if ([ -d "${RunDirs}/spinup_run" ] && "$SetupSpinupRun") || \
       ([ -d "${RunDirs}/jacobian_runs" ] && "$SetupJacobianRuns") || \
       ([ -d "${RunDirs}/inversion" ] && "$SetupInversion") || \
       ([ -d "${RunDirs}/posterior_run" ] && "$SetupPosteriorRun"); then
        printf "\nERROR: Run directories in ${RunDirs}/"
        printf "\n   already exist. Please change RunName or change the"
        printf "\n   Setup* options to false in the IMI config file.\n"
        printf "\n  To proceed, and overwrite existing run directories, set"
        printf "\n  SafeMode in the config file to false.\n" 
        printf "\nIMI $RunName Aborted\n"
        exit 1 
    fi
    # Check if output from previous runs exists
    if ([ -d "${RunDirs}/spinup_run" ] && "$DoSpinup") || \
       ([ -d "${RunDirs}/jacobian_runs" ] && "$DoJacobian") || \
       ([ -d "${RunDirs}/inversion" ] && "$DoInversion") || \
       ([ -d "${RunDirs}/posterior_run/OutputDir/" ] && "$DoPosterior"); then
        printf "\nWARNING: Output files in ${RunDirs}/" 
        printf "\n  may be overwritten. Please change RunName in the IMI"
        printf "\n  config file to avoid overwriting files.\n"
        printf "\n  To proceed, and overwrite existing output files, set"
        printf "\n  SafeMode in the config file to false.\n" 
        printf "\nIMI $RunName Aborted\n"
        exit 1 
    fi
fi
InversionPath=$(pwd -P)
export PYTHONPATH=${PYTHONPATH}:${InversionPath}
mkdir -p -v ${RunDirs}
tropomiCache=${RunDirs}/data_TROPOMI
if "$isAWS"; then
    { # test if instance has access to TROPOMI bucket
        stdout=`aws s3 ls s3://meeo-s5p`
    } || { # catch 
        printf "\nError: Unable to connect to TROPOMI bucket. This is likely caused by misconfiguration of the ec2 instance iam role s3 permissions.\n"
        printf "IMI $RunName Aborted.\n"
        exit 1
    }
    mkdir -p -v $tropomiCache
    printf "Downloading TROPOMI data from S3\n"
    python src/utilities/download_TROPOMI.py $StartDate $EndDate $tropomiCache
    printf "\nFinished TROPOMI download\n"
else
    # use existing tropomi data and create a symlink to it
    if [[ ! -L $tropomiCache ]]; then
	ln -s $DataPathTROPOMI $tropomiCache
    fi
fi
python src/utilities/test_TROPOMI_dir.py $tropomiCache
if "$RunSetup"; then
    setup_imi
fi
setup_end=$(date +%s)
if  "$DoSpinup"; then
    run_spinup
fi
if "$KalmanMode"; then
    setup_kf
    run_kf
fi
if ("$DoJacobian" && ! "$KalmanMode"); then
    run_jacobian
fi
if ("$DoInversion" && ! "$KalmanMode"); then
    run_inversion
fi
if ("$DoPosterior" && ! "$KalmanMode"); then
    run_posterior
fi
printf "\n=== DONE RUNNING THE IMI ===\n"
end_time=$(date)
printf "\nIMI started : %s" "$start_time"
printf "\nIMI ended   : %s" "$end_time"
printf "\n"
if ! "$KalmanMode"; then
    print_stats
fi 
if [[ -f ${InversionPath}/imi_output.log ]]; then
    cp "${InversionPath}/imi_output.log" "${RunDirs}/imi_output.log"
fi
cd $InversionPath
cp $ConfigFile "${RunDirs}/config_${RunName}.yml"
if "$S3Upload"; then
    python src/utilities/s3_upload.py $ConfigFile
fi
exit 0
