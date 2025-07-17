#!/bin/bash
#FLUX: --job-name=misunderstood-nalgas-9070
#FLUX: --queue=jazayeri
#FLUX: -t=36000
#FLUX: --urgency=16

export MW_NVCC_PATH='/cm/shared/openmind/cuda/9.1/bin  # Cuda driver'

echo -e '\n\n'
echo '####################################'
echo '##  STARTING run_kilosort3_np.sh  ##'
echo '####################################'
echo -e '\n\n'
OM2_BASE_DIR=/om2/user/nwatters/multi_prediction
SESSION=$1  # Argument passed in by user. Should be a date string.
echo "SESSION: $SESSION"
OM2_SESSION_DIR=$OM2_BASE_DIR/phys_data/$SESSION
SPIKEGLX_DATA_DIR=$OM2_SESSION_DIR/raw_data/spikeglx
SPIKE_SORTING_DIR=$OM2_SESSION_DIR/spike_sorting
NP_DATA_FILE=$(ls $SPIKEGLX_DATA_DIR/*.bin)
echo "NP_DATA_FILE: ${NP_DATA_FILE}"
NP_METADATA_FILE=$(ls $SPIKEGLX_DATA_DIR/*.meta)
echo "NP_METADATA_FILE: ${NP_METADATA_FILE}"
PROBE_NAME=np_0
WRITE_DIR=${SPIKE_SORTING_DIR}/$PROBE_NAME
echo "WRITE_DIR: ${WRITE_DIR}"
mkdir $WRITE_DIR
echo "Extracting sample rate from metadata file"
BASE_PWD=`pwd`
source /home/nwatters/.bashrc
conda activate phys_analysis
cd ../spikeglx
python extract_sample_rate.py "$NP_METADATA_FILE" "$WRITE_DIR"
cd $BASE_PWD
NEW_UUID=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 8 | head -n 1)
tmp_fn=tmp_ks$NEW_UUID
echo "cd ../kilosort" >> $tmp_fn.m
echo "run_kilosort3_np('$NP_DATA_FILE');" >> $tmp_fn.m
echo "exit;" >> $tmp_fn.m\
echo 'STARTING MATLAB'
export MW_NVCC_PATH=/cm/shared/openmind/cuda/9.1/bin  # Cuda driver
module add openmind/cuda/9.1
module add openmind/cudnn/9.1-7.0.5
module add openmind/gcc/5.3.0
module add mit/matlab/2018b
matlab -nodisplay -r "$tmp_fn"
rm -f $tmp_fn.m
cd $BASE_PWD
echo 'RUNNING SPIKE PROCESSING'
sbatch spike_processing/spike_processing.sh $SESSION $PROBE_NAME ks_3_output_v2
