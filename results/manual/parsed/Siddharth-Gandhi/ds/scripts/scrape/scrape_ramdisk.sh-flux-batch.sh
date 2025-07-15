#!/bin/bash
#FLUX: --job-name=2_7_scrape
#FLUX: -c=3
#FLUX: -t=43200
#FLUX: --priority=16

if [ "$HOSTNAME" != "boston-2-7" ]; then
    echo "Wrong host $HOSTNAME, exiting"
    exit 1
fi
source ~/miniconda3/etc/profile.d/conda.sh
conda activate ds
echo "($HOSTNAME) Current directory: $PWD"
pwd
which python
cp src/scrape_local_v2.py /ssd/ramdisk
cp misc/ /ssd/ramdisk -r
echo "Changing directory to /ssd/ramdisk"
cd /ssd/ramdisk
echo "($HOSTNAME) Current directory: $PWD"
echo "Current files: in $PWD"
ls -l
which python
echo "Running scrape_local.py"
FILE_PATH=test.txt
TOTAL_ITEMS=$(grep -v "^[[:space:]]*$" $FILE_PATH | wc -l)
TOTAL_TASKS=$SLURM_ARRAY_TASK_COUNT
echo "Found $TOTAL_ITEMS items in $FILE_PATH to be processed by $TOTAL_TASKS tasks"
if [ $TOTAL_TASKS -gt $TOTAL_ITEMS ]; then
    echo "WARNING: More tasks than items, reducing number of tasks to $TOTAL_ITEMS"
    TOTAL_TASKS=$TOTAL_ITEMS
fi
ITEMS_PER_TASK=$(( $TOTAL_ITEMS / $TOTAL_TASKS ))
REMAINING_ITEMS=$(( $TOTAL_ITEMS % $TOTAL_TASKS ))
START_INDEX=$(( $SLURM_ARRAY_TASK_ID * $ITEMS_PER_TASK ))
END_INDEX=$(( $START_INDEX + $ITEMS_PER_TASK - 1 ))
echo "Task ID: $SLURM_ARRAY_TASK_ID, Start Index: $START_INDEX, End Index: $END_INDEX"
srun --wait=0 python -u scrape_local_v2.py $FILE_PATH  $START_INDEX $END_INDEX
