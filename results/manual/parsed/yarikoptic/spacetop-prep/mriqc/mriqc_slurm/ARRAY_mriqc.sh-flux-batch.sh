#!/bin/bash
#FLUX: --job-name=spctp_prprc
#FLUX: -n=16
#FLUX: --queue=standard
#FLUX: -t=21600
#FLUX: --priority=16

IMAGE="/dartfs-hpc/rc/lab/C/CANlab/modules/mriqc-0.14.2.sif"
MAINDIR="/dartfs-hpc/rc/lab/C/CANlab/labdata/data/spacetop"
BIDS_DIRECTORY="${MAINDIR}/dartmouth"
SCRATCH_DIR="/scratch/f0042x1/spacetop/preproc"
SCRATCH_WORK="${SCRATCH_DIR}/work"
OUTPUT_DIR="${MAINDIR}/dartmouth/derivatives/mriqc"
OUTPUT_WORK="${OUTPUT_DIR}/work"
subjects=("0001" "0002" "0003" "0004" "0005" "0006" "0007" "0008" "0009" "0010" \
"0011" "0013" "0014" "0015" "0016" "0017" "0020")
SUBJ=${subjects[$SLURM_ARRAY_TASK_ID]}
echo "array id: " ${SLURM_ARRAY_TASK_ID}, "subject id: " ${SUBJ}, "session id: " ${SES_IND}
echo $PATH
echo $PYTHONPATH
unset $PYTHONPATH;
singularity run  \
-B ${BIDS_DIRECTORY}:${BIDS_DIRECTORY} \
-B ${OUTPUT_DIR}:${OUTPUT_DIR} \
-B ${OUTPUT_WORK}:${OUTPUT_WORK} \
${IMAGE} \
--session-id 02 \
-w ${OUTPUT_WORK} \
--n_procs 16 \
--mem_gb 8 \
--ica \
--start-idx 6 \
--fft-spikes-detector \
--write-graph \
--correct-slice-timing \
--fd_thres 0.9 \
${BIDS_DIRECTORY} ${OUTPUT_DIR} participant --participant_label ${SUBJ}
echo "COMPLETING mriqc ... COPYING over"
echo "process complete"
