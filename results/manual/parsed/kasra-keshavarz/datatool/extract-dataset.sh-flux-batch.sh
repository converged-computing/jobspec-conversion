#!/bin/bash
#FLUX: --job-name=buttery-parsnip-5012
#FLUX: --priority=16

function short_usage () {
  echo "Usage: $(basename $0) [-jh] [-i DIR] [-d DATASET] [-co DIR] [-se DATE] [-ln REAL,REAL] [-p STR]
Try \`$(basename $0) --help\` for more options." >&1;
}
function version () {
  echo "$(basename $0): version $(cat $(dirname $0)/VERSION)";
  exit 0;
}
function usage () {
  echo "Meteorological Data Processing Script - version $(cat $(dirname $0)/VERSION)
Usage:
  $(basename $0) [options...]
Script options:
  -d, --dataset                     Meteorological forcing dataset of interest
  -i, --dataset-dir=DIR             The source path of the dataset file(s)
  -v, --variable=var1[,var2[...]]   Variables to process
  -o, --output-dir=DIR              Writes processed files to DIR
  -s, --start-date=DATE             The start date of the data
  -e, --end-date=DATE               The end date of the data
  -l, --lat-lims=REAL,REAL          Latitude's upper and lower bounds
                                    optional; within the [-90, +90] limits
  -n, --lon-lims=REAL,REAL          Longitude's upper and lower bounds
                                    optional; within the [-180, +180] limits
  -a, --shape-file=PATH             Path to the ESRI shapefile; optional
  -m, --ensemble=ens1,[ens2,[...]]  Ensemble members to process; optional
                                    Leave empty to extract all ensemble members
  -M, --model=model1,[model2,[...]] Models that are part of a dataset,
                                    only applicable to climate datasets, optional
  -S, --scenario=scn1,[scn2,[...]]  Climate scenarios to process, only applicable
                                    to climate datasets, optional
  -j, --submit-job                  Submit the data extraction process as a job
                                    on the SLURM system; optional
  -k, --no-chunk                    No parallelization, recommended for small domains
  -p, --prefix=STR                  Prefix  prepended to the output files
  -b, --parsable                    Parsable SLURM message mainly used
                                    for chained job submissions
  -c, --cache=DIR                   Path of the cache directory; optional
  -E, --email=user@example.com      E-mail user when job starts, ends, or
                                    fails; optional
  -u, --account=ACCOUNT             Digital Research Alliance of Canada's sponsor's
                                    account name; optional, defaults to 'rpp-kshook'
  -L, --list-datasets               List all the available datasets and the
                                    corresponding keywords for '--dataset' option
  -V, --version                     Show version
  -h, --help                        Show this screen and exit
For bug reports, questions, discussions open an issue
at https://github.com/kasra-keshavarz/datatool/issues" >&1;
  exit 0;
}
function list_datasets () {
echo "Meteorological Data Processing Script - version $(cat $(dirname $0)/VERSION)
Currently, the following meteorological datasets are
available for processing:
$(cat $(dirname $0)/DATASETS | sed 's/^\(.*\)$/\o033[34m\1\o033[0m/')" >&1;
  exit 0;
}
logDate () { echo "($(date +"%Y-%m-%d %H:%M:%S")) "; }
max () { printf "%s\n" "${@:2}" | sort "$1" | tail -n1; }
alias date='TZ=UTC date'
shopt -s expand_aliases
scriptPath="$(dirname $0)/scripts" # scripts' path
datatoolPath="$(dirname $0)" # datatool's path
extract_submodel="${datatoolPath}/assets/bash_scripts/extract_subdir_level.sh" # script path
parsedArguments=$(getopt -a -n extract-dataset -o jhVbLE:d:i:v:o:s:e:t:l:n:p:c:m:M:S:ka:u: --long submit-job,help,version,parsable,list-datasets,email:,dataset:,dataset-dir:,variable:,output-dir:,start-date:,end-date:,time-scale:,lat-lims:,lon-lims:,prefix:,cache:,ensemble:,model:,scenario:,no-chunk,shape-file:,account: -- "$@")
validArguments=$?
if [ "$validArguments" != "0" ]; then
  short_usage;
  exit 1;
fi
if [ $# -eq 0 ]; then
  short_usage;
  exit 1;
fi
eval set -- "$parsedArguments"
while :
do
  case "$1" in
    -h | --help)          usage                ; shift   ;; # optional
    -V | --version)       version              ; shift   ;; # optional
    -L | --list-datasets) list_datasets        ; shift   ;; # optional
    -j | --submit-job)    jobSubmission=true   ; shift   ;; # optional
    -E | --email)         email="$2"           ; shift 2 ;; # optional
    -i | --dataset-dir)   datasetDir="$2"      ; shift 2 ;; # required
    -d | --dataset)       dataset="$2"         ; shift 2 ;; # required
    -v | --variable)	  variables="$2"       ; shift 2 ;; # required
    -o | --output-dir)    outputDir="$2"       ; shift 2 ;; # required
    -s | --start-date)    startDate="$2"       ; shift 2 ;; # required
    -e | --end-date)      endDate="$2"         ; shift 2 ;; # required
    -t | --time-scale)    timeScale="$2"       ; shift 2 ;; # required
    -l | --lat-lims)      latLims="$2"         ; shift 2 ;; # required
    -n | --lon-lims)      lonLims="$2"         ; shift 2 ;; # required
    -m | --ensemble)      ensemble="$2"        ; shift 2 ;; # optional
    -M | --model)         model="$2"           ; shift 2 ;; # optional
    -S | --scenario)      scenario="$2"        ; shift 2 ;; # optional
    -k | --no-chunk)      parallel=false       ; shift   ;; # optional
    -p | --prefix)        prefixStr="$2"       ; shift 2 ;; # required
    -b | --parsable)	  parsable=true	       ; shift   ;; # optional
    -c | --cache)         cache="$2"           ; shift 2 ;; # optional
    -u | --account)       account="$2"         ; shift 2 ;; # optional
    -a | --shape-file)    shapefile="$2"       ; shift 2 ;; # optional
    # -- means the end of the arguments; drop this, and break out of the while loop
    --) shift; break ;;
    # in case of invalid option
    *) echo "$(basename $0): invalid option '$1'" >$2;
       short_usage;
       exit 1;;
  esac
done
if [[ -z $timeScale ]]; then
  timeScale="M"
fi
if [[ -z $cache ]] && [[ -n $jobSubmission ]]; then
  cache="$HOME/scratch/.temp_data_jobid"
elif [[ -z $cache ]]; then
  cache="$HOME/scratch/.temp_data_$(date +"%N")"
fi
if [[ -z $parallel ]]; then
  parallel=true
fi
if [[ -n $email ]] && [[ -z $jobSubmission ]]; then
  echo "$(basename $0): ERROR! Email is not supported wihtout job submission;"
  exit 1;
fi
if [[ -n $parsable ]] && [[ -z $jobSubmission ]]; then
  echo "$(basename $0): ERROR! --parsable argument cannot be used without job submission"
  exit 1;
fi
if [[ -n $parsable ]]; then
  parsable="--parsable"
else
  parsable=""
fi
if [[ -z $account ]] && [[ $jobSubmission == "true" ]]; then
  account="rpp-kshook"
  if [[ -z $parsable ]]; then
    echo "$(basename $0): WARNING! --account not provided, using \`rpp-kshook\` by default."
  fi
fi
if [[ -n $shapefile ]]; then
  # load GDAL module
  module -q load StdEnv/2020;
  module -q load gcc/9.3.0;
  module -q load gdal/3.4.3;
  # extract the shapefile extent
  IFS=' ' read -ra shapefileExtents <<< "$(ogrinfo -so -al "$shapefile" | sed 's/[),(]//g' | grep Extent)"
  # transform the extents in case they are not in EPSG:4326
  IFS=':' read -ra sourceProj4 <<< "$(gdalsrsinfo $shapefile | grep -e "PROJ.4")" >&2
  # Assuming EPSG:4326 if no definition of the CRS is provided
  if [[ ${#sourceProj4[@]} -eq 0 ]]; then
    echo "$(basename $0): WARNING! Assuming EPSG:4326 for --shape-file as none provided"
    sourceProj4=('PROJ4.J' '+proj=longlat +datum=WGS84 +no_defs')
  fi
  # transform limits and assign to variables
  IFS=' ' read -ra leftBottomLims <<< $(echo "${shapefileExtents[@]:1:2}" | gdaltransform -s_srs "${sourceProj4[1]}" -t_srs EPSG:4326 -output_xy)
  IFS=' ' read -ra rightTopLims <<< $(echo "${shapefileExtents[@]:4:5}" | gdaltransform -s_srs "${sourceProj4[1]}" -t_srs EPSG:4326 -output_xy)
  # define $latLims and $lonLims from $shapefileExtents
  lonLims="${leftBottomLims[0]},${rightTopLims[0]}"
  latLims="${leftBottomLims[1]},${rightTopLims[1]}"
  module -q unload gdal/3.4.3;
fi
if [[ -z "${datasetDir}" ]] || \
   [[ -z "${dataset}"    ]] || \
   [[ -z "${variables}"  ]] || \
   [[ -z "${outputDir}"  ]] || \
   [[ -z "${startDate}"  ]] || \
   [[ -z "${endDate}"    ]] || \
   [[ -z "${latLims}"    ]] || \
   [[ -z "${lonLims}"    ]] || \
   [[ -z "${prefixStr}"  ]]; then
   echo "$(basename $0): mandatory option(s) missing.";
   short_usage;
   exit 1;
fi
startDateArr=() # start dates array
endDateArr=()   # end dates array
unix_epoch () { date --date="$@" +"%s"; } # unix EPOCH date value 
format_date () { date --date="$1" +"$2"; } # format date
dateFormat="%Y-%m-%d %H:%M:%S"
function chunk_dates () {
  # local variables
  local toDate="$startDate"
  local tStep="$1"
  local midDate
  local toDateEnd
  # if no chunking
  if [[ "$parallel" == "false" ]]; then
    startDateArr+=("$(format_date "$startDate" "$dateFormat")")
    endDateArr+=("$(format_date "$endDate" "$dateFormat")")
    return # exit the function
  # if chunking
  elif [[ "$parallel" == "true" ]]; then
    while [[ "$(unix_epoch "$toDate")" -le "$(unix_epoch "$endDate")" ]]; do
      midDate="$(format_date "$toDate" "%Y-%m-01")"
      toDateEnd="$(format_date "$midDate $tStep -1hour" "$dateFormat")"
      # considering last month if not fully being a $tStep
      if [[ "$(unix_epoch "$toDateEnd")" -ge "$(unix_epoch "$endDate")" ]]; then
        startDateArr+=("$(format_date "$toDate" "$dateFormat")")
        endDateArr+=("$(format_date "$endDate" "$dateFormat")")
        break # break the while loop
      fi
      startDateArr+=("$(format_date "$toDate" "$dateFormat")")
      endDateArr+=("$(format_date "$toDateEnd" "$dateFormat")")
      toDate=$(date --date="$midDate $tStep")
    done
  fi
}
declare -A funcArgs=([jobSubmission]="$jobSubmission" \
             [datasetDir]="$datasetDir" \
             [variables]="$variables" \
             [outputDir]="$outputDir" \
             [timeScale]="$timeScale" \
             [startDate]="$startDate" \
             [endDate]="$endDate" \
             [latLims]="$latLims" \
             [lonLims]="$lonLims" \
             [prefixStr]="$prefixStr" \
             [cache]="$cache" \
             [ensemble]="$ensemble" \
             [model]="$model" \
             [scenario]="$scenario"
             );
function call_processing_func () {
  # input arguments as local variables
  local scriptFile="$1" # script local path
  local chunkTStep="$2" # chunking time-frame periods
  local submodelFlag="$3" # flag for submodels' existence
  # local variables
  local scriptName=$(basename $scriptFile | cut -d '.' -f 1) # script/dataset name
  local logDir="$HOME/.datatool/" # local directory for logs
  local jobArrLen
  # make the $logDir if haven't been created yet
  mkdir -p $logDir
  # if dataset contains sub-models, extract them
  if [[ $submodelFlag == 1 ]]; then
    model=$($extract_submodel "$datasetDir" "$model")
    funcArgs[model]=$model
  fi
  # typical script to run for all sub-modules
  local script=$(cat <<- EOF 
	bash ${scriptFile} \
	--dataset-dir="${funcArgs[datasetDir]}" \
	--variable="${funcArgs[variables]}" \
	--output-dir="${funcArgs[outputDir]}" \
	--start-date="${funcArgs[startDate]}" \
	--end-date="${funcArgs[endDate]}" \
	--time-scale="${funcArgs[timeScale]}" \
	--lat-lims="${funcArgs[latLims]}" \
	--lon-lims="${funcArgs[lonLims]}" \
	--prefix="${funcArgs[prefixStr]}" \
	--cache="${funcArgs[cache]}" \
	--ensemble="${funcArgs[ensemble]}" \
	--scenario="${funcArgs[scenario]}" \
	--model="${funcArgs[model]}"
	EOF
  )
  # evaluate the script file using the arguments provided
  if [[ "${funcArgs[jobSubmission]}" == true ]]; then
    # ==========================================
    # Chunk time-frame and other relevant arrays
    # ==========================================
    # chunk dates
    chunk_dates "$chunkTStep"
    # chunking ensemble members
    IFS=',' read -ra ensembleArr <<< $ensemble
    # chunking models
    IFS=',' read -ra modelArr <<< $model
    # chunking scenarios
    IFS=',' read -ra scenarioArr <<< $scenario
    # ===========================
    # Building job array iterator
    # ===========================
    let "ensembleLen = $(max -g ${#ensembleArr[@]} 1)"
    let "modelLen = $(max -g ${#modelArr[@]} 1)"
    let "scenarioLen = $(max -g ${#scenarioArr[@]} 1)"
    let "dateLen = $(max -g ${#startDateArr[@]} 1)"
    let "dateIter = $ensembleLen * $modelLen * $scenarioLen"
    let "ensembleIter = $modelLen * $scenarioLen"
    let "modelIter = $scenarioLen"
    # ==============================
    # Length of processing job array
    # ==============================
    # length of total number of tasks and indices
    let "taskLen = $dateLen * $ensembleLen * $modelLen * $scenarioLen"
    let "jobArrLen = $taskLen - 1"
    # ============
    # Parallel run
    # ============
    # FIXME: This needs to be moved into a template scheduler
    #        document, and various schedulers need to be supported
    sbatch <<- EOF
	#!/bin/bash
	#SBATCH --array=0-$jobArrLen
	#SBATCH --cpus-per-task=4
	#SBATCH --nodes=1
	#SBATCH --account=$account
	#SBATCH --time=04:00:00
	#SBATCH --mem=8000M
	#SBATCH --job-name=DATA_${scriptName}
	#SBATCH --error=$logDir/datatool_%A-%a_err.txt
	#SBATCH --output=$logDir/datatool_%A-%a.txt
	#SBATCH --mail-user=$email
	#SBATCH --mail-type=BEGIN,END,FAIL
	#SBATCH ${parsable}
	$(declare -p startDateArr)
	$(declare -p endDateArr)
	$(declare -p ensembleArr)
	$(declare -p modelArr)
	$(declare -p scenarioArr)
	idxDate="\$(( (\${SLURM_ARRAY_TASK_ID} / ${dateIter}) % ${dateLen} ))"
	idxMember="\$(( (\${SLURM_ARRAY_TASK_ID} / ${ensembleIter}) % ${ensembleLen} ))"
	idxModel="\$(( (\${SLURM_ARRAY_TASK_ID} / ${modelIter}) % ${modelLen} ))"
	idxScenario="\$(( \${SLURM_ARRAY_TASK_ID} % ${scenarioLen} ))"
	tBegin="\${startDateArr[\$idxDate]}"
	tEnd="\${endDateArr[\$idxDate]}"
	memberChosen="\${ensembleArr[\$idxMember]}"
	modelChosen="\${modelArr[\$idxModel]}"
	scenarioChosen="\${scenarioArr[\$idxScenario]}"
	echo "$(logDate)$(basename $0): Calling ${scriptName}.sh..."
	echo "$(logDate)$(basename $0): #\${SLURM_ARRAY_TASK_ID} chunk submitted."
	echo "$(logDate)$(basename $0): Chunk start date is \$tBegin"
	echo "$(logDate)$(basename $0): Chunk end date is   \$tEnd"
	if [[ -n \${modelChosen} ]]; then
	  echo "$(logDate)$(basename $0): Model is            \${modelChosen}"
	fi
	if [[ -n \${scenarioChosen} ]]; then
	  echo "$(logDate)$(basename $0): Scenario is         \${scenarioChosen}"
	fi
	if [[ -n \${memberChosen} ]]; then
	  echo "$(logDate)$(basename $0): Ensemble member is  \${memberChosen}"
	fi
	srun ${script} --start-date="\$tBegin" --end-date="\$tEnd" --cache="${cache}/cache-\${SLURM_ARRAY_JOB_ID}-\${SLURM_ARRAY_TASK_ID}" --ensemble="\${memberChosen}" --model="\${modelChosen}" --scenario="\${scenarioChosen}"
	EOF
    if [[ -z $parsable ]]; then
      echo "$(basename $0): job submission details are printed under $logDir"
    fi
  # serial run
  else
    eval "$script"
  fi
}
case "${dataset,,}" in
  # ============
  # WRF products
  # ============
  # NCAR-GWF CONUSI
  "conus1" | "conusi" | "conus_1" | "conus_i" | "conus 1" | "conus i" | "conus-1" | "conus-i")
    call_processing_func "$scriptPath/gwf-ncar-conus_i/conus_i.sh" "3months"
    ;;
  # NCAR-GWF CONUSII
  "conus2" | "conusii" | "conus_2" | "conus_ii" | "conus 2" | "conus ii" | "conus-2" | "conus-ii")
    call_processing_func "$scriptPath/gwf-ncar-conus_ii/conus_ii.sh" "1month"
    ;;
  # ==========
  # Reanalysis
  # ==========
  # ECMWF ERA5
  "era_5" | "era5" | "era-5" | "era 5")
    call_processing_func "$scriptPath/ecmwf-era5/era5_simplified.sh" "2years"
    ;;
  # ECCC RDRS
  "rdrs" | "rdrsv2.1")
    call_processing_func "$scriptPath/eccc-rdrs/rdrs.sh" "6months"
    ;;
  # ====================
  # Observation datasets
  # ====================
  # Daymet dataset
  "daymet" | "Daymet" )
    call_processing_func "$scriptPath/ornl-daymet/daymet.sh" "5years"
    ;;
  # ================
  # Climate datasets
  # ================
  # ESPO-G6-R2 dataset
  "espo" | "espo-g6-r2" | "espo_g6_r2" | "espo_g6-r2" | "espo-g6_r2" )
    call_processing_func "$scriptPath/ouranos-espo-g6-r2/espo-g6-r2.sh" "151years" "1"
    ;;
  # Ouranos-MRCC5-CMIP6 dataset
  "crcm5-cmip6" | "mrcc5-cmip6" | "crcm5" | "mrcc5" )
    call_processing_func "$scriptPath/ouranos-mrcc5-cmip6/mrcc5-cmip6.sh" "1years"
    ;;
  # Alberta Government Downscaled Climate Dataset - CMIP6
  "alberta" | "ab-gov" | "ab" | "ab_gov" | "abgov" )
    call_processing_func "$scriptPath/ab-gov/ab-gov.sh" "151years" "0"
	;;
  # NASA GDDP-NEX-CMIP6
  "gddp" | "nex" | "gddp-nex" | "nex-gddp" | "gddp-nex-cmip6" | "nex-gddp-cmip6")
    call_processing_func "$scriptPath/nasa-nex-gddp-cmip6/nex-gddp-cmip6.sh" "100years" "0"
	;;
  # CanRCM4-WFDEI-GEM-CaPA
  "canrcm4_g" | "canrcm4-wfdei-gem-capa" | "canrcm4_wfdei_gem_capa")
    call_processing_func "$scriptPath/ccrn-canrcm4_wfdei_gem_capa/canrcm4_wfdei_gem_capa.sh" "5years"
    ;;
  # WFDEI-GEM-CaPA
  "wfdei_g" | "wfdei-gem-capa" | "wfdei_gem_capa" | "wfdei-gem_capa" | "wfdei_gem-capa")
    call_processing_func "$scriptPath/ccrn-wfdei_gem_capa/wfdei_gem_capa.sh" "5years"
    ;;
  # dataset not included above
  *)
    echo "$(basename $0): missing/unknown dataset";
    exit 1;;
esac
