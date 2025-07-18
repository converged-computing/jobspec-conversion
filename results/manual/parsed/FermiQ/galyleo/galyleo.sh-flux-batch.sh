#!/bin/bash
#FLUX: --job-name=loopy-cinnamonbun-8865
#FLUX: --urgency=16

declare -xr GALYLEO_INSTALL_DIR="${PWD}"
declare -xr GALYLEO_CACHE_DIR="${HOME}/.galyleo"
declare -xr CURRENT_LOCAL_TIME="$(date +'%Y%m%dT%H%M%S%z')"
declare -xir CURRENT_UNIX_TIME="$(date +'%s')"
declare -xir RANDOM_ID="${RANDOM}"
source "${GALYLEO_INSTALL_DIR}/lib/slog.sh"
if [[ ! -f "${GALYLEO_INSTALL_DIR}/galyleo.conf" ]]; then
  slog warning -m 'galyleo.conf file does not exist yet.'
else
  source "${GALYLEO_INSTALL_DIR}/galyleo.conf"
  if [[ "${?}" -ne 0 ]]; then
    slog error -m 'Failed to source galyleo.conf file.'
    exit 1
  fi
fi
function galyleo_launch() {
  # Declare galyleo launch mode variable and set its default to 'local'.
  local mode='local'
  # Declare input variables associated with scheduler.
  local account=''
  local reservation=''
  local partition="${GALYLEO_DEFAULT_PARTITION}"
  local qos=''
  local -i nodes=1
  local -i ntasks_per_node=1
  local -i cpus_per_task=1
  local -i memory_per_node=-1
  local gpus=''
  local gres=''
  local time_limit='00:30:00'
  local constraint=''
  # Declare input variables associated with Jupyter runtime environment.
  local jupyter_interface="${GALYLEO_DEFAULT_JUPYTER_INTERFACE}"
  local jupyter_notebook_dir=''
  # Declare input variables associated with system architecture.
  local local_scratch_dir="${GALYLEO_DEFAULT_LOCAL_SCRATCH_DIR}"
  # Declare input variables associated with environment modules.
  local env_modules=''
  # Declare input variables associated with Singularity containers.
  local singularity_image_file=''
  local singularity_bind_mounts=''
  local singularity_gpu_type=''
  # Declare input variables associated with conda environments.
  local conda_init=''
  local conda_pack=''
  local conda_env=''
  local conda_yml=''
  # Declare internal galyelo_launch variables not affected by input variables.
  local job_name="galyleo-${CURRENT_LOCAL_TIME}-${CURRENT_UNIX_TIME}-${RANDOM_ID}"
  local -i job_id=-1
  local http_response=''
  local -i http_status_code=-1
  # Read in command-line options and assign input variables to local
  # variables.
  while (("${#}" > 0)); do
    case "${1}" in
      --mode )
        mode="${2}"
        shift 2
        ;;
      -A | --account )
        account="${2}"
        shift 2
        ;;
      -R | --reservation )
        reservation="${2}"
        shift 2
        ;;
      -p | --partition )
        partition="${2}"
        shift 2
        ;;
      -q | --qos )
        qos="${2}"
        shift 2
        ;;
      -N | --nodes )
        nodes="${2}"
        shift 2
        ;;
      -n | --ntasks-per-node )
        ntasks_per_node="${2}"
        shift 2
        ;;
      -c | --cpus | --cpus-per-task )
        cpus_per_task="${2}"
        shift 2
        ;;
      -m | -M | --memory | --memory-per-node )
        memory_per_node="${2}"
        shift 2
        ;;
      -g | -G | --gpus )
        gpus="${2}"
        shift 2
        ;;
      --gres )
        gres="${2}"
        shift 2
        ;;
      -t | --time-limit )
        time_limit="${2}"
        shift 2
        ;;
      -C | --constraint )
        constraint="${2}"
        shift 2
        ;;
      -j | --jupyter )
        jupyter_interface="${2}"
        shift 2
        ;;
      -d | --notebook-dir )
        jupyter_notebook_dir="${2}"
        shift 2
        ;;
      --scratch-dir )
        local_scratch_dir="${2}"
        shift 2
        ;;
      -e | --env-modules )
        env_modules="${2}"
        shift 2
        ;;
      -s | --sif )
        singularity_image_file="${2}"
        shift 2
        ;;
      -B | --bind )
        singularity_bind_mounts="${2}"
        shift 2
        ;;
      --nv )
        singularity_gpu_type='nv'
        shift 1
        ;;
      --rocm )
        singularity_gpu_type='rocm'
        shift 1
        ;;
      --conda-init )
        conda_init="${2}"
        shift 2
        ;;
      --conda-pack )
        conda_pack="${2}"
        shift 2
        ;;
      --conda-env )
        conda_env="${2}"
        shift 2
        ;;
      --conda-yml )
        conda_yml="${2}"
        shift 2
        ;;
      -Q | --quiet )
        SLOG_LEVEL=0
        shift 1
        ;;
      *)
        slog error -m "Command-line option ${1} not recognized or not supported."
        return 1
    esac
  done
  # Print all command-line options read in for launch to standard output.
  slog output -m ''
  slog output -m 'Preparing galyleo for launch into Jupyter orbit ...'
  slog output -m ''
  slog output -m '  Listing all launch parameters ...'
  slog output -m ''
  slog output -m '    command-line options  : values'
  slog output -m ''
  slog output -m "      -A | --account      : ${account}"
  slog output -m "      -R | --reservation  : ${reservation}"
  slog output -m "      -p | --partition    : ${partition}"
  slog output -m "      -q | --qos          : ${qos}"
  slog output -m "      -c | --cpus         : ${cpus_per_task}"
  slog output -m "      -m | --memory       : ${memory_per_node} GB"
  slog output -m "      -g | --gpus         : ${gpus}"
  slog output -m "         | --gres         : ${gres}"
  slog output -m "      -t | --time-limit   : ${time_limit}"
  slog output -m "      -C | --constraint   : ${constraint}"
  slog output -m "      -j | --jupyter      : ${jupyter_interface}"
  slog output -m "      -d | --notebook-dir : ${jupyter_notebook_dir}"
  slog output -m "         | --scratch-dir  : ${local_scratch_dir}"
  slog output -m "      -e | --env-modules  : ${env_modules}"
  slog output -m "      -s | --sif          : ${singularity_image_file}"
  slog output -m "      -B | --bind         : ${singularity_bind_mounts}"
  slog output -m "         | --nv           : ${singularity_gpu_type}"
  slog output -m "         | --conda-init   : ${conda_init}"
  slog output -m "         | --conda-pack   : ${conda_pack}"
  slog output -m "         | --conda-env    : ${conda_env}"
  slog output -m "         | --conda-yml    : ${conda_yml}"
  slog output -m "      -Q | --quiet        : ${SLOG_LEVEL}"
  slog output -m ''
  # Check if the user specified a Jupyter user interface. If the user
  # did not specify a user interface, then set JupyterLab ('lab') as the
  # default interface.
  if [[ -z "${jupyter_interface}" ]]; then
    jupyter_interface='lab'
  fi
  # Check if a valid Jupyter user interface was specified. At 
  # present, the only two valid user interfaces are JupyterLab ('lab')
  # OR Jupyter Notebook ('notebook'). If an invalid interface name is
  # provided by the user, then halt the launch.
  case "${jupyter_interface}" in
    'lab' )
      ;;
    'notebook' )
      ;;
    *)
    slog error -m "Not a valid Jupyter user interface: ${jupyter_interface}"
    slog error -m "Only --jupyter lab OR --jupyter notebook are allowed."
    return 1
  esac
  # Check if the user specified a working directory for their Jupyter
  # notebook session. If the user did not specify a working directory,
  # then set the working directory to the user's $HOME directory.
  if [[ -z "${jupyter_notebook_dir}" ]]; then
    jupyter_notebook_dir="${HOME}"
  fi
  # Check if the Jupyter notebook directory exists. If it does not
  # exist, then halt the launch.
  if [[ ! -d "${jupyter_notebook_dir}" ]]; then
    slog error -m "Jupyter notebook directory does not exist: ${jupyter_notebook_dir}"
    return 1
  fi
  # Check if the user has write permissions within the Jupyter notebook
  # directory. If the user does not have write permissions, then halt
  # the launch.
  if [[ ! -w "${jupyter_notebook_dir}" ]]; then
    slog error -m "Jupyter notebook directory exists, but you do not have write permissions: ${jupyter_notebook_dir}"
    return 1
  fi
  # Check if all environment modules specified by the user, if any, are
  # available and can be loaded successfully. If not, then halt the launch.
  if [[ -n "${env_modules}" ]]; then
    IFS=','
    read -r -a modules <<< "${env_modules}"
    unset IFS
    for module in "${modules[@]}"; do
      module load "${module}"
      if [[ $? -ne 0 ]]; then
        slog error -m "module not found: ${module}"
        return 1
      fi
    done
  fi
  # Check if the conda environment specified by the user, if any, can be
  # initialized and activated successfully. If not, then halt the launch.
  if [[ -n "${conda_env}" ]]; then
    if [[ -z "${conda_pack}" ]] && [[ -z "${conda_yml}" ]]; then
      if [[ -n "${conda_init}" ]]; then
        source "${conda_init}"
      else
        source ~/.bashrc
      fi
      conda activate "${conda_env}"
      if [[ "${?}" -ne 0 ]]; then
        slog error -m "conda environment could not be activated: ${conda_env}"
        return 1
      fi
    elif [[ -n "${conda_pack}" ]]; then 
      if [[ ! -f "${conda_pack}" ]]; then
        slog error -m "conda environment package file not found: ${conda_pack}"
        return 1
      fi
    elif [[ -n "${conda_yml}" ]]; then
      if [[ ! -f "${conda_yml}" ]]; then
        slog error -m "conda environment yaml file not found: ${conda_yml}"
        return 1 
      fi 
    fi
  fi
  # Check if the Singularity container image file specified by the user,
  # if any, exists. If it does not exist, then halt the launch.
  if [[ -n "${singularity_image_file}" ]]; then
    if [[ ! -f "${singularity_image_file}" ]]; then
      slog error -m "Singularity image file does not exist: ${singularity_image_file}"
      return 1
    fi
  fi
  # Check if Jupyter is available within the software environment 
  # defined by the user. If a Singularity container is required, then
  # also check if the singularity executable is available within the
  # environment defined by the user prior to checking for Jupyter.
  # Otherwise, halt the launch.
  if [[ -n "${singularity_image_file}" ]]; then
    singularity --version > /dev/null
    if [[ "${?}" -ne 0 ]]; then
      slog error -m "No singularity executable was found within the software environment."
      return 1
    else
      timeout 10 singularity exec "${singularity_image_file}" jupyter "${jupyter_interface}" --version > /dev/null
      if [[ "${?}" -ne 0 ]]; then
        slog error -m "Either no jupyter executable was found within the singularity container OR the process used to check for the jupyter executable within the container may have hung and then timed out."
        return 1
      fi
    fi
  else
    if [[ -z "${conda_pack}" ]] && [[ -z "${conda_yml}" ]]; then
      jupyter "${jupyter_interface}" --version > /dev/null
      if [[ "${?}" -ne 0 ]]; then
          slog error -m "No jupyter executable was found within the software environment."
          return 1
      fi
    else
      slog warning -m "Using a packaged conda environment; cannot check if Jupyter is available prior to launch."
    fi
  fi
  # Request a subdomain connection token from reverse proxy service. If the 
  # reverse proxy service returns an HTTP/S error, then halt the launch.
  http_response="$(curl -s -w %{http_code} https://manage.${GALYLEO_REVERSE_PROXY_FQDN}/getlink.cgi -o -)"
  slog output -m "${http_response}"
  http_status_code="$(echo ${http_response} | awk '{print $NF}')"
  if (( "${http_status_code}" != 200 )); then
    slog error -m "Unable to connect to the Satellite reverse proxy service: ${http_status_code}"
    return 1
  fi
  # Extract the reverse proxy connection token and export it as a
  # read-only environment variable.
  declare -xr REVERSE_PROXY_TOKEN="$(echo ${http_response} | awk 'NF>1{printf $((NF-1))}' -)"
  # Generate an authentication token to be used for first-time 
  # connections to the Jupyter notebook server and export it as a 
  # read-only environment variable.
  declare -xr JUPYTER_TOKEN="$(openssl rand -hex 16)"
  # Change present working directory to GALYLEO_CACHE_DIR. Generate and
  # store all Jupyter launch scripts and standard output files in the
  # GALYLEO_CACHE_DIR. Users should not need to access these files when
  # the service is working properly. They will generally only be useful
  # for debugging purposes by SDSC staff. A cleanup function to clear
  # the cache will be provided. We will eventually do some default
  # purging of older files to prevent cache buildup.
  if [[ ! -d "${GALYLEO_CACHE_DIR}" ]]; then
    mkdir -p "${GALYLEO_CACHE_DIR}"
    chmod u+rwx "${GALYLEO_CACHE_DIR}"
    chmod g-rwx "${GALYLEO_CACHE_DIR}"
    chmod o-rwx "${GALYLEO_CACHE_DIR}"
    if [[ "${?}" -ne 0 ]]; then
      slog error -m "Failed to create GALYLEO_CACHE_DIR: ${GALYLEO_CACHE_DIR}"
      return 1
    fi
  fi
  cd "${GALYLEO_CACHE_DIR}"
  # Generate a Jupyter launch script.
  slog output -m ''
  slog output -m 'Generating Jupyter launch script ...'
  if [[ ! -f "${job_name}.sh" ]]; then
    slog append -f "${job_name}.sh" -m '#!/usr/bin/env sh'
    slog append -f "${job_name}.sh" -m ''
    if [[ "${GALYLEO_SCHEDULER}" == 'slurm' ]]; then
      slog append -f "${job_name}.sh" -m "#SBATCH --job-name=${job_name}"
    elif [[ "${GALYLEO_SCHEDULER}" == 'pbs' ]]; then
      slog append -f "${job_name}.sh" -m "#PBS -N ${job_name}"
    fi
    if [[ -n "${account}" ]]; then
      if [[ "${GALYLEO_SCHEDULER}" == 'slurm' ]]; then
        slog append -f "${job_name}.sh" -m "#SBATCH --account=${account}"
      elif [[ "${GALYLEO_SCHEDULER}" == 'pbs' ]]; then
        slog append -f "${job_name}.sh" -m "#PBS -A ${account}"
      fi
    else
      slog error -m 'No account specified. Every job must be charged to an account.'
      rm "${job_name}.sh"
      return 1
    fi
    if [[ -n "${reservation}" ]]; then
      if [[ "${GALYLEO_SCHEDULER}" == 'slurm' ]]; then
        slog append -f "${job_name}.sh" -m "#SBATCH --reservation=${reservation}"
      fi
    fi
    if [[ -n "${qos}" ]]; then
      if [[ "${GALYLEO_SCHEDULER}" == 'slurm' ]]; then
        slog append -f "${job_name}.sh" -m "#SBATCH --qos=${qos}"
      elif [[ "${GALYLEO_SCHEDULER}" == 'pbs' ]]; then
        slog append -f "${job_name}.sh" -m "#PBS -l qos=${qos}"
      fi
    fi
    if [[ "${GALYLEO_SCHEDULER}" == 'slurm' ]]; then
      slog append -f "${job_name}.sh" -m "#SBATCH --partition=${partition}"
    elif [[ "${GALYLEO_SCHEDULER}" == 'pbs' ]]; then
      slog append -f "${job_name}.sh" -m "#PBS -q ${partition}"
    fi
    if [[ "${GALYLEO_SCHEDULER}" == 'slurm' ]]; then
      slog append -f "${job_name}.sh" -m "#SBATCH --nodes=${nodes}"
      slog append -f "${job_name}.sh" -m "#SBATCH --ntasks-per-node=${ntasks_per_node}"
      slog append -f "${job_name}.sh" -m "#SBATCH --cpus-per-task=${cpus_per_task}"
      if [[ -n "${constraint}" ]]; then
        slog append -f "${job_name}.sh" -m "#SBATCH --constraint=${constraint}"
      fi
    elif [[ "${GALYLEO_SCHEDULER}" == 'pbs' ]]; then
      if [[ -n "${constraint}" ]]; then
        slog append -f "${job_name}.sh" -m "#PBS -l nodes=${nodes}:ppn=${cpus_per_task}:${constraint}"
      else
        slog append -f "${job_name}.sh" -m "#PBS -l nodes=${nodes}:ppn=${cpus_per_task}"
      fi
    fi
    if (( "${memory_per_node}" > 0 )); then
      if [[ "${GALYLEO_SCHEDULER}" == 'slurm' ]]; then
        slog append -f "${job_name}.sh" -m "#SBATCH --mem=${memory_per_node}G"
      elif [[ "${GALYLEO_SCHEDULER}" == 'pbs' ]]; then
        slog append -f "${job_name}.sh" -m "#PBS -l mem=${memory_per_node}gb"
      fi
    fi
    if [[ "${GALYLEO_SCHEDULER}" == 'slurm' ]]; then
      if [[ -n "${gpus}" && -z "${gres}" ]]; then
        slog append -f "${job_name}.sh" -m "#SBATCH --gpus=${gpus}"
      elif [[ -z "${gpus}" && -n "${gres}" ]]; then
        slog append -f "${job_name}.sh" -m "#SBATCH --gres=${gres}"
      fi
    fi
    if [[ "${GALYLEO_SCHEDULER}" == 'slurm' ]]; then
      slog append -f "${job_name}.sh" -m "#SBATCH --time=${time_limit}"
    elif [[ "${GALYLEO_SCHEDULER}" == 'pbs' ]]; then
      slog append -f "${job_name}.sh" -m "#PBS -l walltime=${time_limit}"
    fi
    if [[ "${GALYLEO_SCHEDULER}" == 'slurm' ]]; then
      slog append -f "${job_name}.sh" -m "#SBATCH --no-requeue"
    elif [[ "${GALYLEO_SCHEDULER}" == 'pbs' ]]; then
      slog append -f "${job_name}.sh" -m "#PBS -r n"
    fi
    if [[ "${GALYLEO_SCHEDULER}" == 'slurm' ]]; then
      slog append -f "${job_name}.sh" -m "#SBATCH --export=ALL"
    elif [[ "${GALYLEO_SCHEDULER}" == 'pbs' ]]; then
      slog append -f "${job_name}.sh" -m "#PBS -V"
    fi
    if [[ "${GALYLEO_SCHEDULER}" == 'slurm' ]]; then
      slog append -f "${job_name}.sh" -m "#SBATCH --output=${job_name}.o%j.%N"
    elif [[ "${GALYLEO_SCHEDULER}" == 'pbs' ]]; then
      slog append -f "${job_name}.sh" -m "#PBS -j oe"
    fi
    slog append -f "${job_name}.sh" -m ''
    slog append -f "${job_name}.sh" -m "declare -xr LOCAL_SCRATCH_DIR=${local_scratch_dir}"
    slog append -f "${job_name}.sh" -m ''
    slog append -f "${job_name}.sh" -m 'declare -xr JUPYTER_RUNTIME_DIR="${HOME}/.jupyter/runtime"'
    slog append -f "${job_name}.sh" -m 'declare -xi JUPYTER_PORT=-1'
    slog append -f "${job_name}.sh" -m 'declare -xir LOWEST_EPHEMERAL_PORT=49152'
    slog append -f "${job_name}.sh" -m 'declare -i random_ephemeral_port=-1'
    slog append -f "${job_name}.sh" -m ''
    # Load environment modules specified by the user.
    slog append -f "${job_name}.sh" -m 'module purge'
    if [[ -n "${env_modules}" ]]; then
      IFS=','
      read -r -a modules <<< "${env_modules}"
      unset IFS
      for module in "${modules[@]}"; do
        slog append -f "${job_name}.sh" -m  "module load ${module}"
      done
    fi
    # Activate a conda environment specified by the user.
    if [[ -n "${conda_env}" ]]; then
      if [[ -z "${conda_pack}" ]] && [[ -z "${conda_yml}" ]]; then
        if [[ -n "${conda_init}" ]]; then
          slog append -f "${job_name}.sh" -m "source ${conda_init}"
        else
          slog append -f "${job_name}.sh" -m 'source ~/.bashrc'
        fi
        slog append -f "${job_name}.sh" -m "conda activate ${conda_env}"
      elif [[ -n "${conda_pack}" ]] && [[ -z "${conda_yml}" ]]; then
        slog append -f "${job_name}.sh" -m 'cd "${LOCAL_SCRATCH_DIR}"'
        slog append -f "${job_name}.sh" -m "mkdir -p ${conda_env}"
        slog append -f "${job_name}.sh" -m "tar -xf ${conda_pack} -C ${conda_env}"
        slog append -f "${job_name}.sh" -m "source ${conda_env}/bin/activate"
        slog append -f "${job_name}.sh" -m 'conda-unpack'
      elif [[ -z "${conda_pack}" ]] && [[ -n "${conda_yml}" ]]; then
        slog append -f "${job_name}.sh" -m 'cd "${LOCAL_SCRATCH_DIR}"'
        slog append -f "${job_name}.sh" -m 'wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh'
        slog append -f "${job_name}.sh" -m 'chmod +x Miniconda3-latest-Linux-x86_64.sh'
        slog append -f "${job_name}.sh" -m 'export CONDA_INSTALL_PATH="${LOCAL_SCRATCH_DIR}/miniconda3"'
        slog append -f "${job_name}.sh" -m 'export CONDA_ENVS_PATH="${CONDA_INSTALL_PATH}/envs"'
        slog append -f "${job_name}.sh" -m 'export CONDA_PKGS_DIRS="${CONDA_INSTALL_PATH}/pkgs"'
        slog append -f "${job_name}.sh" -m './Miniconda3-latest-Linux-x86_64.sh -b -p "${CONDA_INSTALL_PATH}"'
        slog append -f "${job_name}.sh" -m 'source "${CONDA_INSTALL_PATH}/etc/profile.d/conda.sh"'
        slog append -f "${job_name}.sh" -m 'conda activate base'
        slog append -f "${job_name}.sh" -m "conda env create --file ${conda_yml}"
        slog append -f "${job_name}.sh" -m "conda activate ${conda_env}"
      fi
    fi
    slog append -f "${job_name}.sh" -m ''
    # Change job working directory (from GALYLEO_CACHE_DIR) to jupyter_notebook_dir.
    slog append -f "${job_name}.sh" -m "cd ${jupyter_notebook_dir}"
    slog append -f "${job_name}.sh" -m ''
    # Choose an open ephemeral port at random.
    slog append -f "${job_name}.sh" -m 'while (( "${JUPYTER_PORT}" < 0 )); do'
    slog append -f "${job_name}.sh" -m '  while (( "${random_ephemeral_port}" < "${LOWEST_EPHEMERAL_PORT}" )); do'
    slog append -f "${job_name}.sh" -m '    random_ephemeral_port="$(od -An -N 2 -t u2 -v < /dev/urandom)"'
    slog append -f "${job_name}.sh" -m '  done'
    slog append -f "${job_name}.sh" -m '  ss -nutlp | cut -d : -f2 | grep "^${random_ephemeral_port})" > /dev/null'
    slog append -f "${job_name}.sh" -m '  if [[ "${?}" -ne 0 ]]; then'
    slog append -f "${job_name}.sh" -m '    JUPYTER_PORT="${random_ephemeral_port}"'
    slog append -f "${job_name}.sh" -m '  fi'
    slog append -f "${job_name}.sh" -m 'done'
    slog append -f "${job_name}.sh" -m ''
    # Structure the singularity exec command and its command-line
    # options specified by the user.
    if [[ -n "${singularity_image_file}" ]]; then
      slog append -f "${job_name}.sh" -m 'singularity exec \'
      if [[ -n "${singularity_bind_mounts}" ]]; then
        slog append -f "${job_name}.sh" -m "  --bind ${singularity_bind_mounts} \\"
      fi
      if [[ -n "${singularity_gpu_type}" ]]; then
        slog append -f "${job_name}.sh" -m "  --${singularity_gpu_type} \\"
      fi
      slog append -f "${job_name}.sh" -m "  ${singularity_image_file} \\"
    fi
    # Run the Jupyter server process in the backgroud.
    slog append -f "${job_name}.sh" -m "jupyter ${jupyter_interface} --ip=\"\$(hostname -s).${GALYLEO_DNS_DOMAIN}\" --notebook-dir='${jupyter_notebook_dir}' --port=\"\${JUPYTER_PORT}\" --NotebookApp.allow_origin='*' --KernelManager.transport='ipc' --no-browser &"
    slog append -f "${job_name}.sh" -m 'if [[ "${?}" -ne 0 ]]; then'
    slog append -f "${job_name}.sh" -m "  echo 'ERROR: Failed to launch Jupyter.'"
    slog append -f "${job_name}.sh" -m '  exit 1'
    slog append -f "${job_name}.sh" -m 'fi'
    slog append -f "${job_name}.sh" -m ''
    # Redeem the connection token from reverse proxy service to enable
    # proxy mapping.
    slog append -f "${job_name}.sh" -m 'curl "https://manage.${GALYLEO_REVERSE_PROXY_FQDN}/redeemtoken.cgi?token=${REVERSE_PROXY_TOKEN}&port=${JUPYTER_PORT}"'
    slog append -f "${job_name}.sh" -m ''
    # Wait for the Jupyter server to be shutdown by the user.
    slog append -f "${job_name}.sh" -m 'wait'
    slog append -f "${job_name}.sh" -m ''
    # Revoke the connection token from reverse proxy service once the
    # Jupyter server has been shutdown.
    slog append -f "${job_name}.sh" -m 'curl "https://manage.${GALYLEO_REVERSE_PROXY_FQDN}/destroytoken.cgi?token=${REVERSE_PROXY_TOKEN}"'
  else
    slog error -m 'Jupyter launch script already exists. Cannot overwrite.'
    return 1
  fi
  # Submit Jupyter launch script to scheduler.
  if [[ "${GALYLEO_SCHEDULER}" == 'slurm' ]]; then
    job_id="$(sbatch ${job_name}.sh | grep -o '[[:digit:]]*')"
    if [[ "${?}" -ne 0 ]]; then
      slog error -m 'Failed job submission to Slurm.'
      http_response="$(curl -s https://manage.${GALYLEO_REVERSE_PROXY_FQDN}/destroytoken.cgi?token=${REVERSE_PROXY_TOKEN})"
      slog output -m "${http_response}"
      return 1
    else
      slog output -m "Submitted Jupyter launch script to Slurm. Your SLURM_JOB_ID is ${job_id}."
    fi
  elif [[ "${GALYLEO_SCHEDULER}" == 'pbs' ]]; then
    job_id="$(qsub ${job_name}.sh | grep -o '^[[:digit:]]*')"
    if [[ "${?}" -ne 0 ]]; then
      slog error -m 'Failed job submission to PBS.'
      http_response="$(curl -s https://manage.${GALYLEO_REVERSE_PROXY_FQDN}/destroytoken.cgi?token=${REVERSE_PROXY_TOKEN})"
      slog output -m "${http_response}"
      return 1
    else
      slog output -m "Submitted Jupyter launch script to PBS. Your PBS_JOBID is ${job_id}."
    fi
  fi
  # Associate batch job id to the connection token from the reverse proxy service.
  http_response="$(curl -s https://manage.${GALYLEO_REVERSE_PROXY_FQDN}/linktoken.cgi?token=${REVERSE_PROXY_TOKEN}\&jobid=${job_id})"
  slog output -m "${http_response}"
  # Always print to standard output the URL where the Jupyter notebook 
  # server may be accessed by the user.
  slog output -m 'Please copy and paste the HTTPS URL provided below into your web browser.'
  slog output -m 'Do not share this URL with others. It is the password to your Jupyter notebook session.'
  slog output -m 'Your Jupyter notebook session will begin once compute resources are allocated to your job by the scheduler.'
  echo "https://${REVERSE_PROXY_TOKEN}.${GALYLEO_REVERSE_PROXY_FQDN}?token=${JUPYTER_TOKEN}"
  return 0
}
function galyleo_configure() {
  # Declare local variables associated with reverse proxy service.
  local reverse_proxy_fqdn='expanse-user-content.sdsc.edu'
  local dns_domain='eth.cluster'
  # Declare default variables associated with scheduler.
  local scheduler='slurm'
  local partition='shared'
  # Declare default variables associated with Jupyter runtime environment.
  local jupyter_interface='lab'
  # Declare input variables associated with system architecture.
  local local_scratch_dir='/tmp'
  # Read in command-line options and assign input variables to local
  # variables.
  while (("${#}" > 0)); do
    case "${1}" in
      -r | --reverse-proxy )
        reverse_proxy_fqdn="${2}"
        shift 2
        ;;
      -D | --dns-domain )
        dns_domain="${2}"
        shift 2
        ;;
      -s | --scheduler )
        scheduler="${2}"
        shift 2
        ;;
      -p | --partition )
        partition="${2}"
        shift 2
        ;;
      -j | --jupyter )
        jupyter_interface="${2}"
        shift 2
        ;;
      --scratch-dir )
        local_scratch_dir="${2}"
        shift 2
        ;;
      *)
        slog error -m "Command-line option ${1} not recognized or not supported."
        return 1
    esac
  done
  # If the galyleo configuration file already exists, do not let the
  # galyleo configure command reconfigure and overwrite it. This is
  # intended to force the original configuration file owner --- e.g.,
  # the system administrator who deployed galyleo --- to manually
  # remove the existing configuration file first. If the configuration
  # file does not exist yet, then create it.
  if [[ -f "${GALYLEO_INSTALL_DIR}/galyleo.conf" ]]; then
    slog error -m 'galyleo.conf cannot be overwritten with this command.'
    return 1
  else
     slog output -m 'Setting GALYLEO_INSTALL_DIR ... '
     sed -i "s|\"\${PWD}\"|'${PWD}'|" 'galyleo.sh'
     slog output -m 'Creating galyleo.conf file ... '
     slog append -f 'galyleo.conf' -m '#!/usr/bin/env sh'
     slog append -f 'galyleo.conf' -m "declare -xr GALYLEO_REVERSE_PROXY_FQDN='${reverse_proxy_fqdn}'"
     slog append -f 'galyleo.conf' -m "declare -xr GALYLEO_DNS_DOMAIN='${dns_domain}'"
     slog append -f 'galyleo.conf' -m "declare -xr GALYLEO_SCHEDULER='${scheduler}'"
     slog append -f 'galyleo.conf' -m "declare -xr GALYLEO_DEFAULT_PARTITION='${partition}'"
     slog append -f 'galyleo.conf' -m "declare -xr GALYLEO_DEFAULT_JUPYTER_INTERFACE='${jupyter_interface}'"
     slog append -f 'galyleo.conf' -m "declare -xr GALYLEO_DEFAULT_LOCAL_SCRATCH_DIR='${local_scratch_dir}'"
  fi
  slog output -m 'galyleo configuration complete.'
  return 0
}
function galyleo_clean() {
  rm -r "${GALYLEO_CACHE_DIR}"
  return 0
}
function galyleo_help() {
  slog output -m ''
  slog output -m 'USAGE: galyleo launch [command-line option] {value}'
  slog output -m ''
  slog output -m '  command-line options  : (default) values'
  slog output -m ''
  slog output -m "    -A | --account      : ${account}"
  slog output -m "    -R | --reservation  : ${reservation}"
  slog output -m "    -p | --partition    : ${partition}"
  slog output -m "    -q | --qos          : ${qos}"
  slog output -m "    -c | --cpus         : ${cpus_per_task}"
  slog output -m "    -m | --memory       : ${memory_per_node} GB"
  slog output -m "    -g | --gpus         : ${gpus}"
  slog output -m "       | --gres         : ${gres}"
  slog output -m "    -t | --time-limit   : ${time_limit}"
  slog output -m "    -j | --jupyter      : ${jupyter_interface}"
  slog output -m "    -d | --notebook-dir : ${jupyter_notebook_dir}"
  slog output -m "       | --scratch-dir  : ${local_scratch_dir}"
  slog output -m "    -e | --env-modules  : ${env_modules}"
  slog output -m "    -s | --sif          : ${singularity_image_file}"
  slog output -m "    -B | --bind         : ${singularity_bind_mounts}"
  slog output -m "       | --nv           : ${singularity_gpu_type}"
  slog output -m "    -e | --env-modules  : ${env_modules}"
  slog output -m "       | --conda-init   : ${conda_init}"
  slog output -m "       | --conda-pack   : ${conda_pack}"
  slog output -m "       | --conda-env    : ${conda_env}"
  slog output -m "    -Q | --quiet        : ${SLOG_LEVEL}"
  slog output -m ''
  return 0
}
function galyleo() {
  # Define local variables.
  local galyleo_command
  # Assign default values to local variables.
  galyleo_command=''
  # If at least one command-line argument was provided by the user, then
  # start parsing the command-line arguments. Otherwise, throw an error.
  if (( "${#}" > 0 )); then
    # Read in the first command-line argument, which is expected to be 
    # the main command issued by the user.
    galyleo_command="${1}"
    shift 1
    # Determine if the command provided by user is a valid. If it is a
    # valid command, then execute that command. Otherwise, throw an error.
    if [[ "${galyleo_command}" = 'launch' ]]; then
      galyleo_launch "${@}"
      if [[ "${?}" -ne 0 ]]; then
        slog error -m 'galyleo_launch command failed.'
        exit 1
      fi
    elif [[ "${galyleo_command}" = 'configure' ]]; then
      galyleo_configure "${@}"
      if [[ "${?}" -ne 0 ]]; then
        slog error -m 'galyleo_configure command failed.'
        exit 1
      fi
    elif [[ "${galyleo_command}" = 'clean' ]]; then
      galyleo_clean
      if [[ "${?}" -ne 0 ]]; then
        slog error -m 'galyleo_clean command failed.'
        exit 1
      fi
    elif [[ "${galyleo_command}" = 'help' || \
            "${galyleo_command}" = '-h' || \
            "${galyleo_command}" = '--help' ]]; then
      galyleo_help
      if [[ "${?}" -ne 0 ]]; then
        slog error -m 'galyleo_help command failed.'
        exit 1
      fi
    else
      slog error -m 'Command not recognized or not supported.'
      exit 1
    fi
  else
    slog error -m 'No command-line arguments were provided.'
    exit 1
  fi
  exit 0
}
galyleo "${@}"
