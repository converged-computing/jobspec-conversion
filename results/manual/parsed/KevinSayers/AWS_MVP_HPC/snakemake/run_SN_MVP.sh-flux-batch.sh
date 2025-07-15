#!/bin/bash
#FLUX: --job-name="CCBRPipeline"
#FLUX: -c=2
#FLUX: --queue="norm"
#FLUX: -t=345600
#FLUX: --priority=16

export SINGULARITY_CACHEDIR='/data/gangalapudiv2/singularity'

PYTHON_VERSION="python/3.7"
SNAKEMAKE_VERSION="snakemake/5.24.1"
set -eo pipefail
module purge
SCRIPTNAME="$0"
SCRIPTBASENAME=$(readlink -f $(basename $0))
EXTRA_SINGULARITY_BINDS="-B /data/khanlab/projects/vin/singularity"
export SINGULARITY_CACHEDIR="/data/gangalapudiv2/singularity"
function get_git_commitid_tag() {
  cd $1
  gid=$(git rev-parse HEAD)
  tag=$(git describe --tags $gid 2>/dev/null)
  echo -ne "$gid\t$tag"
}
PIPELINE_HOME=$(readlink -f $(dirname "$0"))
echo "Pipeline Dir: $PIPELINE_HOME"
SNAKEFILE="${PIPELINE_HOME}/workflow/Snakefile"
GIT_COMMIT_TAG=$(get_git_commitid_tag $PIPELINE_HOME)
echo "Git Commit/Tag: $GIT_COMMIT_TAG"
function usage() { 
    cat << EOF
${SCRIPTBASENAME}
--> run ervTelescope pipeline
USAGE:
  bash ${SCRIPTNAME} -m/--runmode=<RUNMODE> -w/--workdir=<WORKDIR>
Required Arguments:
1.  RUNMODE: [Type: String] Valid options:
    *) init : initialize workdir
    *) run : run with slurm
    *) reset : DELETE workdir dir and re-init it
    *) dryrun : dry run snakemake to generate DAG
    *) unlock : unlock workdir if locked by snakemake
    *) runlocal : run without submitting to sbatch
2.  WORKDIR: [Type: String]: Absolute or relative path to the output folder with write permissions.
EOF
}
function err() { 
cat <<< "
  $@
" && usage && exit 1 1>&2; 
}
function init() {
if [ -d $WORKDIR ];then err "Folder $WORKDIR already exists!"; fi
mkdir -p $WORKDIR
sed -e "s/PIPELINE_HOME/${PIPELINE_HOME//\//\\/}/g" -e "s/WORKDIR/${WORKDIR//\//\\/}/g" ${PIPELINE_HOME}/config/config.yaml > $WORKDIR/config.yaml
cp ${PIPELINE_HOME}/config/samples.tsv $WORKDIR/
if [ ! -d $WORKDIR/logs ]; then mkdir -p $WORKDIR/logs;echo "Logs Dir: $WORKDIR/logs";fi
if [ ! -d $WORKDIR/stats ];then mkdir -p $WORKDIR/stats;echo "Stats Dir: $WORKDIR/stats";fi
echo "Done Initializing $WORKDIR. You can now edit $WORKDIR/config.yaml and $WORKDIR/samples.tsv"
}
function check_essential_files() {
  if [ ! -d $WORKDIR ];then err "Folder $WORKDIR does not exist!"; fi
  for f in config.yaml samples.tsv; do
    if [ ! -f $WORKDIR/$f ]; then err "Error: '${f}' file not found in workdir ... initialize first!";fi
  done
}
function reconfig(){
  check_essential_files
  sed -e "s/PIPELINE_HOME/${PIPELINE_HOME//\//\\/}/g" -e "s/WORKDIR/${WORKDIR//\//\\/}/g" ${PIPELINE_HOME}/config/config.yaml > $WORKDIR/config.yaml
  echo "$WORKDIR/config.yaml has been updated!"
}
function runcheck(){
  check_essential_files
  module load $PYTHON_VERSION
  module load $SNAKEMAKE_VERSION
}
function dryrun() {
  runcheck
  run "--dry-run"
}
function unlock() {
  runcheck
  run "--unlock"  
}
function set_singularity_binds(){
    local gpfs_links link gpfs_dirs add_comma
    gpfs_links="$(ls -d /gs*)"
    # check to see if any gs* links are broken
    for link in $gpfs_links; do
        if [ -e "${link}" ]; then
            gpfs_dirs+="${add_comma:-}${link}"
            # only prepend the comma _after_ the first iteration
            add_comma=,
        fi
    done
    SINGULARITY_BINDS="-B ${gpfs_dirs:-},/vf,/spin1,/data,/fdb,/gpfs"
}
function printbinds(){
  set_singularity_binds
  echo $SINGULARITY_BINDS
}
function runlocal() {
  runcheck
  if [ "$SLURM_JOB_ID" == "" ];then err "runlocal can only be done on an interactive node"; fi
  module load singularity
  run "local"
}
function runslurm() {
  runcheck
  set_singularity_binds
  run "slurm"
}
function preruncleanup() {
  echo "Running..."
  # check initialization
  check_essential_files 
  cd $WORKDIR
  ## Archive previous run files
  if [ -f ${WORKDIR}/snakemake.log ];then 
    modtime=$(stat ${WORKDIR}/snakemake.log |grep Modify|awk '{print $2,$3}'|awk -F"." '{print $1}'|sed "s/ //g"|sed "s/-//g"|sed "s/://g")
    mv ${WORKDIR}/snakemake.log ${WORKDIR}/stats/snakemake.${modtime}.log
    if [ -f ${WORKDIR}/snakemake.log.HPC_summary.txt ];then 
      mv ${WORKDIR}/snakemake.log.HPC_summary.txt ${WORKDIR}/stats/snakemake.${modtime}.log.HPC_summary.txt
    fi
    if [ -f ${WORKDIR}/snakemake.stats ];then 
      mv ${WORKDIR}/snakemake.stats ${WORKDIR}/stats/snakemake.${modtime}.stats
    fi
  fi
  nslurmouts=$(find ${WORKDIR} -maxdepth 1 -name "slurm-*.out" |wc -l)
  if [ "$nslurmouts" != "0" ];then
    for f in $(ls ${WORKDIR}/slurm-*.out);do mv ${f} ${WORKDIR}/logs/;done
  fi
}
function run() {
  if [ "$1" == "local" ];then
  preruncleanup
  snakemake -s $SNAKEFILE \
  --directory $WORKDIR \
  --printshellcmds \
  --use-singularity \
  --singularity-args "$SINGULARITY_BINDS" \
  --use-envmodules \
  --latency-wait 120 \
  --configfile ${WORKDIR}/config.yaml \
  --singularity-prefix ${WORKDIR}/singularity \
  --cores all \
  --stats ${WORKDIR}/snakemake.stats \
  2>&1|tee ${WORKDIR}/snakemake.log
  if [ "$?" -eq "0" ];then
    snakemake -s $SNAKEFILE \
    --report ${WORKDIR}/runlocal_snakemake_report.html \
    --directory $WORKDIR \
    --configfile ${WORKDIR}/config.yaml 
  fi
  elif [ "$1" == "slurm" ];then
  preruncleanup
  cat > ${WORKDIR}/submit_script.sbatch << EOF
module load $PYTHON_VERSION
module load $SNAKEMAKE_VERSION
module load singularity
cd \$SLURM_SUBMIT_DIR
snakemake -s $SNAKEFILE \
--directory $WORKDIR \
--use-singularity \
--singularity-args "$SINGULARITY_BINDS" \
--use-envmodules \
--printshellcmds \
--latency-wait 120 \
--configfile ${WORKDIR}/config.yaml \
--singularity-prefix ${WORKDIR}/singularity \
--cluster-config ${PIPELINE_HOME}/resources/cluster.json \
--cluster "sbatch --gres {cluster.gres} --cpus-per-task {cluster.threads} -p {cluster.partition} -t {cluster.time} --mem {cluster.mem} --job-name {cluster.name} --output {cluster.output} --error {cluster.error}" \
-j 500 \
--rerun-incomplete \
--keep-going \
--stats ${WORKDIR}/snakemake.stats \
2>&1|tee ${WORKDIR}/snakemake.log
if [ "\$?" -eq "0" ];then
  snakemake -s $SNAKEFILE \
  --directory $WORKDIR \
  --report ${WORKDIR}/runslurm_snakemake_report.html \
  --configfile ${WORKDIR}/config.yaml 
fi
bash <(curl https://raw.githubusercontent.com/CCBR/Tools/master/Biowulf/gather_cluster_stats.sh 2>/dev/null) ${WORKDIR}/snakemake.log > ${WORKDIR}/snakemake.log.HPC_summary.txt
EOF
  sbatch ${WORKDIR}/submit_script.sbatch
  else # for unlock and dryrun 
snakemake $1 -s $SNAKEFILE \
--directory $WORKDIR \
--use-envmodules \
--printshellcmds \
--latency-wait 120 \
--configfile ${WORKDIR}/config.yaml \
--cluster-config ${PIPELINE_HOME}/config/cluster.json \
--cluster "sbatch --gres {cluster.gres} --cpus-per-task {cluster.threads} -p {cluster.partition} -t {cluster.time} --mem {cluster.mem} --job-name {cluster.name} --output {cluster.output} --error {cluster.error}" \
-j 500 \
--rerun-incomplete \
--keep-going \
--stats ${WORKDIR}/snakemake.stats
  fi
}
function reset() {
  echo "Working Dir: $WORKDIR"
  if [ ! -d $WORKDIR ];then err "Folder $WORKDIR does not exist!";fi
  echo "Deleting $WORKDIR"
  rm -rf $WORKDIR
  echo "Re-Initializing $WORKDIR"
  init
}
function main(){
  if [ $# -eq 0 ]; then usage; exit 1; fi
  for i in "$@"
  do
  case $i in
      -m=*|--runmode=*)
        RUNMODE="${i#*=}"
      ;;
      -w=*|--workdir=*)
        WORKDIR="${i#*=}"
      ;;
      *)
        err "Unknown argument!"    # unknown option
      ;;
  esac
  done
  WORKDIR=$(readlink -f "$WORKDIR")
  echo "Working Dir: $WORKDIR"
  case $RUNMODE in
    init) init && exit 0;;
    dryrun) dryrun && exit 0;;
    unlock) unlock && exit 0;;
    run) runslurm && exit 0;;
    runlocal) runlocal && exit 0;;
    reset) reset && exit 0;;
    dry) dryrun && exit 0;;                      # hidden option
    local) runlocal && exit 0;;                  # hidden option
    reconfig) reconfig && exit 0;;               # hidden option for debugging
    *) err "Unknown RUNMODE \"$RUNMODE\"";;
  esac
}
main "$@"
