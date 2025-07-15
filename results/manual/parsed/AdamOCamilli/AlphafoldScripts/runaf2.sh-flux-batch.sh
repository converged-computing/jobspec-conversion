#!/bin/bash
#FLUX: --job-name=crusty-citrus-5957
#FLUX: -t=172800
#FLUX: --urgency=16

export alphafold_path='/cluster/tufts/cmdb295class/shared/alphafold/alphafold'

function usage() {
  scriptName=$(basename $0);
  printf "usage: ./$scriptName [-h] [-o DIRECTORY] [-e DIRECTORY] [FILE/DIRECTORY]\n"
  printf "Run one or more Alphafold batch jobs for each protein sequence file in a directory. You can also pass in individual sequence files.\n\n"
  printf "  -h         display help\n"
  printf "  -e error   specify output directory \n"
  printf "             default format: alphafold_error_<current datetime>\n"
  printf "  -o output  specify error directory  (in current directory by default)\n"
  printf "             default format: alphafold_output_<current datetime>\n"
}
function run_sbatch () {
sbatch <<EOT
export alphafold_path=/cluster/tufts/cmdb295class/shared/alphafold/alphafold
module load cuda/11.0 cudnn/8.0.4-11.0 anaconda/2021.05
module list
nvidia-smi
source activate af2
python3 /cluster/tufts/cmdb295class/shared/alphafold/alphafold/run_af2.py \
--output_dir=$2 \
--fasta_paths=$3
EOT
}
numArg=$#
errorDir=""
eFlag=""
outputDir=""
oFlag=""
proteinFiles=()
while getopts he:o: flag; do
  case "${flag}" in
    h) 
      usage
      exit 0;;
    e) 
       eFlag=1
       errorDir="$(realpath $OPTARG)"
       mkdir -p $errorDir;;
    o)
       oFlag=1
       outputDir="$(realpath $OPTARG)"
       mkdir -p $outputDir;;
   esac
done
shift $(($OPTIND - 1))
currentDateTime="$(date +%Y%m%d_%H%M%S)"
errorTitle="alphafold_error_$currentDateTime"
outputTitle="alphafold_output_$currentDateTime"
if  [[ -z $eFlag ]];
then
  mkdir $errorTitle
  errorDir="$(realpath ./$errorTitle)"
fi
if [[ -z $oFlag ]];
then
  mkdir $outputTitle
  outputDir="$(realpath ./$outputTitle)"
fi
if [[ -d $* ]]; 
then	
  shopt -s nullglob # don't match empty files
  for file in "$1"/*.{fasta,fa}; do
    proteinFiles+=("$(realpath $file)")
  done
  shopt -u nullglob
  for proteinFile in "${proteinFiles[@]}"; do
    proteinDir=$(basename $proteinFile)
    proteinErrorDir="$errorDir/${proteinDir%.*}"  
    mkdir -p $proteinErrorDir
    run_sbatch $proteinErrorDir $outputDir $proteinFile
  done
  exit 0
elif [[ -f $* ]];
then
  proteinDir=$(basename $*)
  proteinErrorDir="$errorDir/${proteinDir%.*}"  
  mkdir -p $proteinErrorDir
  run_sbatch $proteinErrorDir $outputDir $*
  exit 0
else
  echo "Invalid or nonexistent directory $*"
  usage
  exit 1
fi
