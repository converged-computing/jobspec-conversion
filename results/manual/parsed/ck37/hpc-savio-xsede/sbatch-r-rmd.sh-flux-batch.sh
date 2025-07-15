#!/bin/bash
#FLUX: --job-name=moolicious-egg-7642
#FLUX: -t=172800
#FLUX: --urgency=16

dir_output=.
use_spark=0
make_rmd=0
for i in "$@"
do
case $i in
    -f=*|--file=*)
    file="${i#*=}"
    # If the filename ends in .Rmd turn on Rmd handling.
    if [ ${file: -4} == ".Rmd" ]; then
      echo "Detected Rmd file."
      make_rmd=1
      file_raw="${i#*=}"
      shopt -s extglob    # Turn on extended pattern support
      # Remove .Rmd if it's included in the filename, for use later.
      file=${file_raw%.Rmd}
    fi
    ;;
    -d=*|--dir=*)
    dir_output="${i#*=}"
    ;;
    --spark)
    use_spark=1
    ;;
    # TODO: support manually turning on Rmd processing.
esac
done
module load r
module load gcc/4.8.5
module load java
module load lapack
module load cuda cudnn
if [ $use_spark == 1 ]; then
  # NOTE: this requires the java module.
  # NOTE: this module should have been loaded prior to calling this sbatch.
  # I.e. run on login node, not within the SLURM call.
  # module load spark
  source /global/home/groups/allhands/bin/spark_helper.sh
  # This will start 1 worker per available node in $SLURM_NODELIST.
  # Logs etc. will be in /global/scratch/$USER/spark/bash.<number>/log/
  spark-start
fi;
set -x
if [ $make_rmd == 1 ]; then
  # knitr does not support subdirectories - need to use cd.
  cd $dir_output
  # This assumes we are in a subdirectory; remove "../" if not.
  # TODO: detect automatically if dir_output changed directories or not.
  Rscript -e "knitr::knit('../$file.Rmd', '$file.md')" 2>&1
  # Check if the markdown file was generated.
  if [ -f "$file.md" ]; then
    # Convert markdown to html
    # Alternatively could use pandoc on the command line.
    Rscript -e "markdown::markdownToHTML('$file.md', '$file.html')"
  else
    echo "Error: Markdown file $file.md does not exist. Can't create html file."
  fi
else
  # Add job id to output file in case multiple versions of script are running
  # simultaneously.
  R CMD BATCH --no-save --no-restore ${file} ${dir_output}/${file}-${SLURM_JOB_ID}.out
fi;
if [ $use_spark == 1 ]; then
  # Shut down spark cluster.
  spark-stop
fi;
