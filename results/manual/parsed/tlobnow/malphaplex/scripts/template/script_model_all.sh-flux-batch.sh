#!/bin/bash
#FLUX: --job-name=delicious-animal-9264
#FLUX: -c=72
#FLUX: -t=86400
#FLUX: --urgency=16

export LD_LIBRARY_PATH='${ALPHAFOLD_HOME}/lib:${LD_LIBRARY_PATH}'
export TMPDIR='${JOB_SHMTMPDIR}'
export TF_XLA_FLAGS='--tf_xla_enable_xla_devices'
export TF_FORCE_UNIFIED_MEMORY='1'
export XLA_PYTHON_CLIENT_MEM_FRACTION='4'
export NUM_THREADS='${SLURM_CPUS_PER_TASK}'
export OMP_NUM_THREADS='${SLURM_CPUS_PER_TASK}'

set -e
module purge
module load cuda/11.4
module load anaconda/3/2021.11
export LD_LIBRARY_PATH=${ALPHAFOLD_HOME}/lib:${LD_LIBRARY_PATH}
export TMPDIR=${JOB_SHMTMPDIR}
export TF_XLA_FLAGS=--tf_xla_enable_xla_devices
export TF_FORCE_UNIFIED_MEMORY=1
        # Enable jax allocation tweak to allow for larger models, note that
        # with unified memory the fraction can be larger than 1.0 (=100% of single GPU memory):
        # https://jax.readthedocs.io/en/latest/gpu_memory_allocation.html
        # When using 2 GPUs:
export XLA_PYTHON_CLIENT_MEM_FRACTION=4
        # run threaded tools with the correct number of threads (MPCDF customization)
export NUM_THREADS=${SLURM_CPUS_PER_TASK}
export OMP_NUM_THREADS=${SLURM_CPUS_PER_TASK}
source 00_user_parameters.inc
source 01_user_parameters.inc
        # file name
        # data directory (where are params stored)
        # target list location
        # feature directory location
        # output directory
        # model_names
        # preset
        # model_preset
        # recycling setting
        # msa pairing
echo "Info: input file name is $FILE"
echo "Info: input target list is $TARGET_LST_FILE"
echo "Info: input feature directory is $FEA_DIR"
echo "Info: result output directory is $OUT_DIR"
echo "Info: model preset is $MODEL_PRESET"
echo "Info: msa pairing is $MSA_PAIRING"
echo "Info: recycling setting is $RECYCLING_SETTING"
srun $PYTHON_PATH/python3 -u $AF_DIR/run_af2c_mod.py \
  --target_lst_path=$TARGET_LST_FILE \
  --data_dir=$DATA_DIR \
  --output_dir=$OUT_DIR \
  --feature_dir=$FEA_DIR \
  --model_names=model_1_multimer_v3,model_2_multimer_v3,model_3_multimer_v3,model_4_multimer_v3,model_5_multimer_v3 \
  --preset=$PRESET \
  --model_preset=multimer_np\
  --save_recycled=$RECYCLING_SETTING \
  --msa_pairing=$MSA_PAIRING &
srun $PYTHON_PATH/python3 -u $AF_DIR/run_af2c_mod.py \
  --target_lst_path=$TARGET_LST_FILE \
  --data_dir=$DATA_DIR \
  --output_dir=$OUT_DIR \
  --feature_dir=$FEA_DIR \
  --model_names=model_1_ptm,model_2_ptm,model_3_ptm,model_4_ptm,model_5_ptm \
  --preset=$PRESET \
  --model_preset=monomer_ptm\
  --save_recycled=$RECYCLING_SETTING \
  --msa_pairing=$MSA_PAIRING
