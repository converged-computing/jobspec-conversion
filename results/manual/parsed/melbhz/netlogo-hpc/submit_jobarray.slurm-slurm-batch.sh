#!/bin/bash
#SBATCH --job-name=COVIDModel-Snowy
#SBATCH --account=punim1439
#SBATCH --mail-user=jason.thompson@unimelb.edu.au
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --time=02:00:00
#SBATCH --partition=snowy
#SBATCH --qos=covid19
#SBATCH --array=1-100

module load java
BASE_FOLDER='/path/to/your/slurm/xxxx/xxxx/directory' #REVISE HERE: The base folder is where the slurm file lives
cd $BASE_FOLDER
NETLOGO_SH='/xxx/xxxx/NetLogo 6.2.0/netlogo-headless.sh' #REVISE HERE: The path about your NetLogo software
NETLOGO_MODEL='/xxxx/xxx/xxxx/xxx.nlogo' #REVISE HERE: The path of *.nlogo file
THREADS=8 #REVISE HERE: Same value as cpus-per-task is recommended; 1 to disable parallel runs; slightly larger value may speed up model run.
EXPERIMENT="xmls/exp_${SLURM_ARRAY_TASK_ID}.xml"
TABLE_SUFFIX="_table"
OUTPUT_FOLDER="outputs_snowy" #this folder will be created, this is where to see output files
OUTPUT_TABLE=${OUTPUT_FOLDER}/"${SLURM_ARRAY_TASK_ID}${TABLE_SUFFIX}_${SLURM_ARRAY_TASK_ID}.csv"
mkdir -p ${BASE_FOLDER}/$OUTPUT_FOLDER
echo "output folder: $OUTPUT_FOLDER"
starttime=$(date '+%d/%m/%Y %H:%M:%S')
echo "job ${SLURM_JOBID}_${SLURM_ARRAY_TASK_ID} started  at $starttime"
"$NETLOGO_SH" \
  --model "$NETLOGO_MODEL" \
  --setup-file "$EXPERIMENT" \
  --table "$OUTPUT_TABLE" \
  --threads $THREADS
endtime=$(date '+%d/%m/%Y %H:%M:%S')
echo "job ${SLURM_JOBID}_${SLURM_ARRAY_TASK_ID} finished at $endtime"
