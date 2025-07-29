#!/bin/bash
#FLUX: --job-name=thl_dw
#FLUX: --queue=gpu_requeue,seas_gpu
#FLUX: -t=80
#FLUX: --urgency=16

PARAM_FILE=slurm_params.txt
MY_PARAMS=$(sed "${SLURM_ARRAY_TASK_ID}q;d" ${PARAM_FILE})
TMP=(${MY_PARAMS///})
IL="${TMP[0]}"
MLPL="${TMP[1]}"
ITER="${TMP[2]}"
STDOF="${TMP[3]}"
PEF="${TMP[4]}"
R="${TMP[5]}"
RU="${TMP[6]}"
MODE="mono"
DMIN=1.8
TEST_FRACTION=0.1
SEED=$RANDOM
BASENAME=thl_1p8A_grid
HALF_REPEATS=3
INPUT_MTZS=(
    ../unmerged_mtzs/friedel_plus.mtz
    ../unmerged_mtzs/friedel_minus.mtz
)
DW_LIST=None,0
USE_DW="DW"
DWR_LIST=0.,${R}
eval "$(conda shell.bash hook)"
conda activate careless
OUT=merge_${SLURM_JOB_ID}_${SEED}_${MODE}_cl3_mc1_grid_${SLURM_ARRAY_TASK_ID}
mkdir -p $OUT
cp $0 $OUT
cat $0 > $OUT/slurm_script
SECONDS=0
CARELESS_ARGS=(
    --mc-samples=1
    --learning-rate=0.001
    --separate-files
    --merge-half-datasets
    --half-dataset-repeats=$HALF_REPEATS
    --mlp-layers=$MLPL
    --image-layers=$IL
    --dmin=$DMIN
    --iterations=$ITER
    --test-fraction=$TEST_FRACTION
    --seed=$SEED
    --mlp-width=4
)
c=$(echo "$R > -0.01" | bc)
if [ $c = '1' ]
then
  CARELESS_ARGS+=(--double-wilson-parents=${DW_LIST})
  CARELESS_ARGS+=(--double-wilson-r=${DWR_LIST})
fi
if [ $IL -lt 0 ]
then
  CARELESS_ARGS+=( --disable-image-scales)
fi
if [ $RU -gt 0 ]
then
  CARELESS_ARGS+=( --refine-uncertainties)
fi
if [ $STDOF -gt 0 ]
then
  CARELESS_ARGS+=( --studentt-likelihood-dof=$STDOF)
fi
CARELESS_ARGS+=("dHKL,xobs,yobs,ewald_offset")
echo $CARELESS_ARGS
echo "Careless version (from sbatch script): ${CARELESS_VERSION}"
echo "Input MTZs: ${INPUT_MTZS[@]}" > ./$OUT/inputs_params.log
echo "Args: $MODE ${CARELESS_ARGS[@]}" >> ./$OUT/inputs_params.log
conda list > ./$OUT/conda_env_record.log
careless $MODE ${CARELESS_ARGS[@]} ${INPUT_MTZS[@]} $OUT/$BASENAME
echo "careless run complete."
mv myoutput*${SLURM_JOB_ID}* $OUT #DH added
DURATION=$SECONDS
TITLE="Slurm: careless"
MESSAGE="Job $SLURM_JOB_ID:careless finished on $HOSTNAME in $(($DURATION / 60)) minutes."
echo $MESSAGE
