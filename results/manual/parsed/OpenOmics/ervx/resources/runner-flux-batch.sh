#!/bin/bash
#FLUX: --job-name=$2
#FLUX: -c=16
#FLUX: -t=432000
#FLUX: --urgency=16

set -eu
function usage() { cat << EOF
runner: Job submission wrapper script for the RNA-seek pipeline.
USAGE:
  runner <MODE> [OPTIONS] -j MASTER_JOB_NAME -b SINGULARITY_BIND_PATHS
SYNOPSIS:
  This script creates/submits the RNA-seek master job to the cluster. The master job
acts as the pipeline's main controller or its main process. This main job dictates
how subsequent jobs are submitted to the cluster via the SLURM job scheduler. Support
for additional job schedulers (i.e. PBS, SGE, LSF, Tibanna) may be added in the future.
  The main entry point of the pipeline 'rna-seek' calls this job submission wrapper script.
As so, this script can be used to by-pass 'rna-seek' for a previously failed run; meaning,
it can be used to re-run the pipeline to pick back off where the last failure occurred
or re-start the pipeline.
  Please Note: it is highly recommended to use 'rna-seek'; it is the main entry point
and preferred entry point of the RNA-seek pipeline. If you are experience error, it
maybe due to improperly mounting singularity bind paths which 'rna-seek' will internally
handle.
Required Positional Argument:
  [1] MODE  [Type: Str] Define the snakemake executor mode.
                        Valid mode options include: <slurm>
                         a) slurm: uses slurm and singularity snakemake backend.
                             The slurm EXECUTOR will submit jobs to the cluster.
                             It is recommended running RNA-seek in this mode as
                             most of the steps are computationally intensive.
Required Arguments:
  -j, --job-name [Type: Str]    Name of pipeline's master job.
  -b, --bind-paths [Type:Path]  Singularity bind paths. The RNA-seek pipeline uses
                                 singaularity images for exection. Bind paths are
                                 used to mount the host filesystem to the container's
                                 filesystem. Multiple bind paths can be provided
                                 as a comma seperated list. The main entry point
                                 of the pipeline internally collects and aggregates
                                 bindpaths to mount to the container's filesystem.
                                 If you are manually running this script or by-passing
                                 rna-seek, you will need to provide the bindpaths of
                                 the rawdata directory(s) along with the pipeline's
                                 output directory. Please see example usage below.
  -t, --tmp-dir [Type:Path]      Temporary directory. The pipeline generates
                                 intermediate, temporary output files. Any 
                                 temporary output files will be written to
                                 this location. On Biowulf, it should be 
                                 set to '/lscratch/\$SLURM_JOBID/'. On FRCE,
                                 this value should be set to the following: 
                                 '/scratch/cluster_scratch/\$USER/'. 
OPTIONS:
  -o,  --outdir  [Type: Path]  Path to output directory. If not provided, the Path
                                will default to the current working directory of
                                this script [Default: $(dirname  "$0")]
  -c,  --cache  [Type: Path]   Path to singularity cache. If not provided, the Path
                                will default to the current working directory of
                                this script [Default: $(dirname  "$0")/.singularity/]
  -h, --help     [Type: Bool]  Displays usage and help information.
Example:
  $ runner slurm -h
  $ runner slurm -j RNA-seek_hg38 -b "/scratch/$USER/rawdata,/scratch/$USER/RNA_hg38,/data/CCBR_Pipeliner/db/PipeDB/,/lscratch,/fdb"
Version:
  0.1.0
EOF
}
function err() { cat <<< "$@" 1>&2; }
function fatal() { cat <<< "$@" 1>&2; usage; exit 1; }
function abspath() { readlink -e "$1"; }
function parser() {
  # Adds parsed command-line args to GLOBAL $Arguments associative array
  # + KEYS = short_cli_flag ("j", "o", ...)
  # + VALUES = parsed_user_value ("MasterJobName" "/scratch/hg38", ...)
  # @INPUT "$@" = user command-line arguments
  # @CALLS check() to see if the user provided all the required arguments
  while [[ $# -gt 0 ]]; do
    key="$1"
    case $key in
      -h  | --help) usage && exit 0;;
      -j  | --job-name)   provided "$key" "${2:-}"; Arguments["j"]="$2"; shift; shift;;
      -b  | --bind-paths) provided "$key" "${2:-}"; Arguments["b"]="$2"; shift; shift;;
      -t  | --tmp-dir) provided "$key" "${2:-}"; Arguments["t"]="$2"; shift; shift;;
      -o  | --outdir)  provided "$key" "${2:-}"; Arguments["o"]="$2"; shift; shift;;
      -c  | --cache)  provided "$key" "${2:-}"; Arguments["c"]="$2"; shift; shift;;
      -*  | --*) err "Error: Failed to parse unsupported argument: '${key}'."; usage && exit 1;;
      *) err "Error: Failed to parse unrecognized argument: '${key}'. Do any of your inputs have spaces?"; usage && exit 1;;
    esac
  done
  # Check for required args
  check
}
function provided() {
  # Checks to see if the argument's value exists
  # @INPUT $1 = name of user provided argument
  # @INPUT $2 = value of user provided argument
  # @CALLS fatal() if value is empty string or NULL
  if [[ -z "${2:-}" ]]; then
     fatal "Fatal: Failed to provide value to '${1}'!";
  fi
}
function check(){
  # Checks to see if user provided required arguments
  # @INPUTS $Arguments = Global Associative Array
  # @CALLS fatal() if user did NOT provide all the $required args
  # List of required arguments
  local required=("j" "b" "t")
  for arg in "${required[@]}"; do
    value=${Arguments[${arg}]:-}
    if [[ -z "${value}" ]]; then
      fatal "Failed to provide all required args.. missing ${arg}"
    fi
  done
}
function require(){
  # Requires an executable is in $PATH, as a last resort it will attempt to load
  # the executable or dependency as a module
  # @INPUT $@ = List of dependencies or executables to check
  for exe in "${@}"; do
    # Check if executable is in $PATH
    command -V ${exe} &> /dev/null && continue;
    # Try to load exe as lua module
    module load ${exe} &> /dev/null || \
      fatal "Failed to find or load '${exe}', not installed on target system."
  done
}
function submit(){
  # Submit jobs to the defined job scheduler or executor (i.e. slurm)
  # INPUT $1 = Snakemake Mode of execution
  # INPUT $2 = Name of master/main job or process (pipeline controller)
  # INPUT $3 = Pipeline output directory
  # INPUT $4 = Singularity Bind paths
  # INPUT $5 = Singularity cache directory
  # INPUT $6 = Temporary directory for output files
  # Check if singularity and snakemake are in $PATH
  # If not, try to module load singularity as a last resort
  require singularity snakemake
  # Snakemake executor
  executor=${1}
  # Goto Pipeline Ouput directory
  # Create a local singularity cache in output directory
  # cache can be re-used instead of re-pulling from DockerHub everytime
  cd "$3" && export SINGULARITY_CACHEDIR="${5}"
  # unsetting XDG_RUNTIME_DIR to avoid some unsighly but harmless warnings
  unset XDG_RUNTIME_DIR
  # Run the workflow with specified executor
  case "$executor" in
    slurm)
          # Create directory for logfiles
          mkdir -p "$3"/logfiles/slurmfiles/
          CLUSTER_OPTS="sbatch --gres {cluster.gres} --cpus-per-task {cluster.threads} -p {cluster.partition} -t {cluster.time} --mem {cluster.mem} --job-name={params.rname}"
          # Check if NOT running on Biowulf
          # Assumes other clusters do NOT 
          # have GRES for local node disk,
          # long term it might be worth 
          # adding a new option to allow 
          # a user to decide whether to 
          # use GRES at job submission,
          # trying to infer this because
          # most users will not even know
          # what GRES is and how or why
          # it should be used and by default
          # SLURM is not configured to use 
          # GRES, remove prefix single quote
          if [[ ${6#\'} != /lscratch* ]]; then
            CLUSTER_OPTS="sbatch --cpus-per-task {cluster.threads} -p {cluster.partition} -t {cluster.time} --mem {cluster.mem} --job-name={params.rname}"
          fi
    cat << EOF > kickoff.sh
set -euo pipefail            
snakemake --latency-wait 120 -s "$3"/workflow/Snakefile -d "$3" \\
  --use-singularity --singularity-args "'-B $4'" --configfile="$3"/config.json \\
  --printshellcmds --cluster-config "$3"/resources/cluster_slurm.json \\
  --cluster "${CLUSTER_OPTS}" \\
  --keep-going --restart-times 3 -j 500 --rerun-incomplete --stats "$3"/logfiles/runtime_statistics.json \\
  --keep-remote --local-cores 14 2>&1
snakemake -d "$3" -s "$3/workflow/Snakefile" \\
   --report "Snakemake_Report.html"
EOF
          chmod +x kickoff.sh
          job_id=$(sbatch kickoff.sh | tee -a "$3"/logfiles/master.log)
        ;;
    uge)
          # Create directory for logfiles
          mkdir -p "$3/logfiles/ugefiles/"
          UGE_DIR="$3/logfiles/ugefiles"
          CLUSTER_OPTS="qsub -pe threaded {cluster.threads} {cluster.partition} -l h_vmem={cluster.mem} -N {params.rname} -o '$UGE_DIR/uge-\\\$JOB_ID-{params.rname}.out' -j y"
          # Create qsub script for master job
    cat << EOF > kickoff.sh
set -euo pipefail
snakemake --latency-wait 120 -s "$3/workflow/Snakefile" -d "$3" \\
  --use-singularity --singularity-args "'-B $4'" \\
  --configfile="$3/config.json" \\
  --printshellcmds --cluster-config "$3"/resources/cluster_uge.json \\
  --cluster "${CLUSTER_OPTS}" --keep-going --restart-times 3 -j 500 \\
  --rerun-incomplete --stats "$3/logfiles/runtime_statistics.json" \\
  --keep-remote --local-cores 14 2>&1
snakemake -d "$3" -s "$3/workflow/Snakefile" \\
  --report "Snakemake_Report.html"
EOF
    chmod +x kickoff.sh
    job_id=$(qsub -terse kickoff.sh | tee -a "$3"/logfiles/master.log)
        ;;
      *)  echo "${executor} is not available." && \
          fatal "Failed to provide valid execution backend: ${executor}. Please use slurm or uge."
        ;;
    esac          
  # Return exit-code of pipeline sumbission
  echo "$job_id"
}
function main(){
  # Parses args and runs initializes output directory, setups cromwell, and runs pipeline
  # @INPUT "$@" = command-line arguments
  # @CALLS parser(), initialize(), setup(), cromwell()
  if [ $# -eq 0 ]; then usage; exit 1; fi
  # Associative array to store parsed args
  declare -Ag Arguments
  # Positional Argument for Snakemake Executor
  case $1 in
    slurm) Arguments["e"]="$1";;
    uge) Arguments["e"]="$1";;
    -h    | --help | help) usage && exit 0;;
    -*    | --*) err "Error: Failed to provide required positional argument: <slurm,uge>."; usage && exit 1;;
    *) err "Error: Failed to provide valid positional argument. '${1}' is not supported. Valid option(s) are slurm or uge"; usage && exit 1;;
  esac
  # Parses remaining user provided command-line arguments
  parser "${@:2}" # Remove first item of list
  # Setting defaults for non-required arguments
  # If output directory is not provided, default to scripts current working directory
  outdir=$(abspath $(dirname  "$0"))
  Arguments[o]="${Arguments[o]:-$outdir}"
  Arguments[o]="${Arguments[o]%/}" # clean outdir path (remove trailing '/')
  # If singularity cache not provided, default to ${outdir}/.singularity
  cache="${Arguments[o]}/.singularity"
  Arguments[c]="${Arguments[c]:-$cache}"
  Arguments[c]="${Arguments[c]%/}" # clean outdir path (remove trailing '/')
  # Print pipeline metadata prior to running
  echo -e "\nRNA-seek\t$(date)"
  echo -e "Running pipeline with the following parameters:"
  for key in "${!Arguments[@]}"; do echo -e "\t${key}\t${Arguments["$key"]}"; done
  # Step 1. Run pipeline and submit jobs to cluster using the defined executor
  mkdir -p "${Arguments[o]}/logfiles/"
  job_id=$(submit "${Arguments[e]}" "${Arguments[j]}" "${Arguments[o]}" "${Arguments[b]}" "${Arguments[c]}" "${Arguments[t]}")
  echo -e "[$(date)] Pipeline submitted to cluster.\nMaster Job ID: $job_id"
  echo "${job_id}" > "${Arguments[o]}/logfiles/mjobid.log"
}
main "$@"
