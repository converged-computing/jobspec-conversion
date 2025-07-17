#!/bin/bash
#FLUX: --job-name=fuzzy-fudge-0752
#FLUX: -c=48
#FLUX: --urgency=16

export PATH='~/aws-cli/bin:$PATH'

set -x
module purge
module load anaconda
module load anaconda3/2022.05
conda activate flepimop-env
which python
which Rscript
export PATH=~/aws-cli/bin:$PATH
mv slurm-$SLURM_ARRAY_JOB_ID_${SLURM_ARRAY_TASK_ID}.out $FS_RESULTS_PATH/slurm-$SLURM_ARRAY_JOB_ID_${SLURM_ARRAY_TASK_ID}.out
curl \
  -H "Title: $FLEPI_RUN_INDEX Done ✅" \
  -H "Priority: urgent" \
  -H "Tags: warning,snail" \
  -d "Hopefully the results look alright" \
  ntfy.sh/flepimop_alerts
source /data/struelo1/flepimop-code/slack_credentials.sh # populate $SLACK_TOKEN
rm -r pplot
mkdir pplot
source $FLEPI_PATH/batch/postprocessing-scripts.sh
cp -R pplot $FS_RESULTS_PATH
if [[ $S3_UPLOAD == "true" ]]; then
    aws s3 cp --quiet pplot $S3_RESULTS_PATH/pplot
fi
