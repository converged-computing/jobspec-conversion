#!/bin/bash
#FLUX: --job-name=hi-c_hydrad
#FLUX: --queue=commons
#FLUX: -t=28799
#FLUX: --urgency=16

printf -v LOOP_NUM "%06d" $SLURM_ARRAY_TASK_ID
RESULTS_DIR=$SHARED_SCRATCH/wtb2/hi_c_simulation
HYDRAD_DIR=$SHARED_SCRATCH/wtb2/hi_c_simulation/HYDRAD_clean
RUN_DIR=${RESULTS_DIR}/hydrodynamics/loop${LOOP_NUM}
REDUCED_FILENAME=${RESULTS_DIR}/hydrodynamics/reduced_results/loop${LOOP_NUM}_uniform.h5
module load Anaconda3/5.0.0
source activate hic_simulation
rm -rf $RUN_DIR
echo "Configuring initial conditions for loop$LOOP_NUM"
srun python $HOME/hi_c_simulation/configure_for_hydrad.py --loop_number $LOOP_NUM --interface_path $HOME/hi_c_simulation --ar_path $RESULTS_DIR/noaa12712_base --hydrad_path $HYDRAD_DIR --results_path $RESULTS_DIR/hydrodynamics
cp $RUN_DIR/hydrad_tools_config.asdf $RESULTS_DIR/hydrodynamics/config_files/loop$LOOP_NUM.hydrad_config.asdf
cd $RUN_DIR
echo "Starting HYDRAD run for loop$LOOP_NUM on "`date`
srun ${RUN_DIR}/HYDRAD.exe >> ${RUN_DIR}/job_status.out
rm $REDUCED_FILENAME
echo "Reducing HYDRAD data for loop$LOOP_NUM"
srun python $HOME/hi_c_simulation/make_uniform_grid.py --hydrad_root $RUN_DIR --output_file $REDUCED_FILENAME
source deactivate
