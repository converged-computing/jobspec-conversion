#!/bin/bash
#FLUX: --job-name=heudiconv_%s_%s
#FLUX: -c=4
#FLUX: -t=14400
#FLUX: --urgency=16

sbatch_template="#!/bin/bash
module load StdEnv/2020 apptainer/1.1.8
singularity pull -o "${SCRATCH}/" docker://nipy/heudiconv:latest
source /home/spinney/project/spinney/neuroimaging-preprocessing/venv/bin/activate
TMP_DIR=\"\${SCRATCH}/%s/%s\"
mkdir -p \"\${TMP_DIR}\"
tar -xzvf \"%s\" -C \"\${TMP_DIR}\"
cd \"\${TMP_DIR}/*/DICOM\"  # Change to the DICOM directory
mv * \"\${TMP_DIR}\"/  # Move DICOM files up one level
cd \"\${TMP_DIR}\"  # Change back to the session directory
rm -rf \"\${TMP_DIR}/localscratch\"
heudiconv -d \$TMP_DIR -s \"%s\" -ss \"%s\" -f /home/spinney/projects/def-patricia/spinney/neuroimaging-datalad-workflow/src/data/heuristics_neuroventure.py -c dcm2niix -b --overwrite -o \"\${TMP_DIR}/bids\"
BIDS_DIR=\"%s/%s/%s\"
mkdir -p \$BIDS_DIR
rsync -av \"\${TMP_DIR}/bids\" \$BIDS_DIR
"
for subject_dir in "$root_dir"/sub-*; do
    if [ -d "$subject_dir" ]; then
        subject_id=$(basename "$subject_dir")
        # Loop through session directories
        for session_dir in "$subject_dir"/ses-*; do
            if [ -d "$session_dir" ]; then
                session_id=$(basename "$session_dir")
                # Use a wildcard to match tar.gz files in the session directory
                tar_files=("$session_dir"/"${subject_id}"*.tar.gz)
                if [ ${#tar_files[@]} -gt 0 ]; then
                    for tar_file in "${tar_files[@]}"; do
                        # Create a Slurm sbatch script for each tar.gz file
                        sbatch_script="$slurm_dir"/"${subject_id}"_"${session_id}"_heudiconv.sbatch
                        # Generate the Slurm script by replacing placeholders in the template
                        sbatch_script_content=$(printf "$sbatch_template" "$subject_id" "$session_id" "$subject_id" "$session_id" "$subject_id" "$session_id"  "$subject_id" "$session_id" "$TMP_DIR" "$subject_id" "$session_id"  "$bids_dir" "$subject_id" "$session_id")
                        # Write the content to the Slurm script file
                        echo -e "$sbatch_script_content" > "$sbatch_script"
                        # Uncomment the line below to submit the Slurm job
                        #sbatch "$sbatch_script"
                        echo "Generated Slurm job for subject $subject_id, session $session_id, tar file: $tar_file"
                    done
                else
                    echo "No tar.gz files found for subject $subject_id, session $session_id"
                fi
            fi
        done
    fi
done
