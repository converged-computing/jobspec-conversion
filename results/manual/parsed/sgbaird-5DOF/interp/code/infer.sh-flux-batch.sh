#!/bin/bash
#FLUX: --job-name=red-caramel-9665
#FLUX: --urgency=16

mkdir ~/.matlab/$SLURM_ARRAY_JOB_ID.$SLURM_ARRAY_TASK_ID
unset TZ
module load matlab/r2018b
tid=$SLURM_ARRAY_TASK_ID
if [ "$for_type" = "parallel" ]; then
pc_opts="pc=parcluster('local'); pc.JobStorageLocation = '~/.matlab/$SLURM_ARRAY_JOB_ID.$SLURM_ARRAY_TASK_ID'; parpool(pc,$inf_cores);"
echo "pc_opts: $pc_opts"
fi
echo "load_filepath: $load_filepath
jid: $jid
tid: $tid
for_type: $for_type
"
walltime_name="walltime$jid"
walltime=${!walltime_name}
echo "walltime: $walltime"
matlab -nodisplay -nosplash -r "clear all; $pc_opts; sse_inference($load_filepath, $jid, $tid)"
rm -rf ~/.matlab/$SLURM_ARRAY_JOB_ID.$SLURM_ARRAY_TASK_ID
