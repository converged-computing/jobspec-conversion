#!/bin/bash
#FLUX: --job-name=eval
#FLUX: -t=3600
#FLUX: --priority=16

module purge  # suggested in alliancecan docs: https://docs.alliancecan.ca/wiki/Running_jobs
module load python/3.10 StdEnv/2020 gcc/9.3.0 arrow/10.0
PROJECT_NAME="mediqa-eval"
ACCOUNT_NAME="rrg-wanglab"
source "$HOME/$PROJECT_NAME/bin/activate"
cd "$HOME/projects/$ACCOUNT_NAME/$USER/MEDIQA-Chat-2023" || exit
FN_GOLD="$1"    # The path on disk to the JSON config file
FN_SYS="$2"     # The path on disk to save the output to
TASK="$3"       # Task, should be taskA or taskB
OUTPUT_FN="$4"  # Output filename
if [[ "$TASK" == "taskA" ]]; then
  NOTE_COLUMN="SystemOutput2"
else
  NOTE_COLUMN="SystemOutput"
fi
python ./scripts/evaluate_summarization.py \
    --fn_gold "$FN_GOLD" \
    --fn_sys "$FN_SYS" \
    --task "$TASK" \
    --id_column "TestID" \
    --note_column $NOTE_COLUMN \
    --dialogue_column "dialogue" \
    --use_section_check \
    --experiment "$OUTPUT_FN"
exit
