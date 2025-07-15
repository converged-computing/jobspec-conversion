#!/bin/bash
#FLUX: --job-name=stinky-pot-7581
#FLUX: --priority=16

usage () {
  echo "$0 NOTEBOOK [NOTEBOOK2 ... NOTEBOOKN]"
  echo "Submit job(s) to run all notebooks on casper node via jupyter nbconvert"
  echo ""
  echo "For each specified file, the full call is:"
  echo "jupyter nbconvert --to notebook --inplace --ExecutePreprocessor.kernel_name=python \\
                  --ExecutePreprocessor.timeout=3600 --execute NOTEBOOK"
  echo ""
  echo "Output from the pbs job is written in the logs/ directory,"
  echo "which will be created if it does not exist."
}
submit_pbs_script () {
  nbname=`echo ${notebook} | sed -e "s/ /_/g"`
  echo "running ${notebook}.ipynb..."
  cat > ${nbname}.sub << EOF
${set_env}
jupyter nbconvert --to notebook --inplace --ExecutePreprocessor.kernel_name=python \\
                  --ExecutePreprocessor.timeout=3600 --execute "${notebook}.ipynb"
EOF
  qsub ${nbname}.sub
  rm -f ${nbname}.sub
}
submit_slurm_script () {
  nbname=`echo ${notebook} | sed -e "s/ /_/g"`
  echo "running ${notebook}.ipynb..."
  cat > ${nbname}.sub << EOF
${set_env}
jupyter nbconvert --to notebook --inplace --ExecutePreprocessor.kernel_name=python \\
                  --ExecutePreprocessor.timeout=3600 --execute "${notebook}.ipynb"
EOF
  sbatch ${nbname}.sub
  rm -f ${nbname}.sub
}
if [ $# == 0 ]; then
  usage
  exit 1
fi
for args in "$@"
do
  if [ "$args" == "-h" ] || [ "$args" == "--help" ]; then
    usage
    exit 0
  fi
done
set_env="export PATH=/glade/work/${USER}/miniconda3/bin/:$PATH ; source activate hires-marbl || exit -1"
mkdir -p logs
for notebook_full in "$@"
do
  if [ ! -f "${notebook_full}" ]; then
    echo "WARNING: can not find ${notebook_full}"
    continue
  fi
  notebook=`echo ${notebook_full} | cut -d '.' -f 1`
  submit_pbs_script $notebook
done
