#!/bin/bash
#FLUX: --job-name=astute-motorcycle-4319
#FLUX: --urgency=16

echo "Loading LAMMPS: lammps/29Sep2021 --------------------------"
module load lammps/29Sep2021
echo "Changing to LAMMPS project directory ------------------------------"
cd /home/amkurth/Development/lammps_project
if [ "$#" -ne 7 ]; then
    echo "Usage: $0 NAME INPUT_SCRIPT TASKS PARTITION QOS TIME TAG"
    exit 1
fi
NAME="$1"
INPUT_SCRIPT="$2"
TASKS="$3"
PARTITION="$4"
QOS="$5"
TIME="$6"
RUN="${NAME}_${TAG}"  # Use underscore for clarity
SLURMFILE="${RUN}.sh"
OUTPUT_DIR="./${RUN}"
echo "Parameters: NAME=$NAME, INPUT_SCRIPT=$INPUT_SCRIPT, TASKS=$TASKS, PARTITION=$PARTITION, QOS=$QOS, TIME=$TIME"
echo "Submitting to SLURM ------------------------------"
echo "#!/bin/sh" > $SLURMFILE
echo "#SBATCH --job-name=$RUN" >> $SLURMFILE
echo "#SBATCH --output=$OUTPUT_DIR/%x.out" >> $SLURMFILE
echo "#SBATCH --error=$OUTPUT_DIR/%x.err" >> $SLURMFILE
echo "#SBATCH --time=$TIME" >> $SLURMFILE
echo "#SBATCH --ntasks=$TASKS" >> $SLURMFILE
echo "#SBATCH --partition=$PARTITION" >> $SLURMFILE
echo "#SBATCH --qos=$QOS" >> $SLURMFILE
echo "#SBATCH --chdir=$PWD" >> $SLURMFILE
echo "" >> $SLURMFILE
LAMMPS_EXEC="lmp"
echo "$LAMMPS_EXEC -in $INPUT_SCRIPT > $OUTPUT_DIR/$RUN.out 2> $OUTPUT_DIR/$RUN.err" >> $SLURMFILE
mkdir -p "$OUTPUT_DIR"
sbatch $SLURMFILE
echo "Submitted SLURM job: $RUN ------------------------------"
