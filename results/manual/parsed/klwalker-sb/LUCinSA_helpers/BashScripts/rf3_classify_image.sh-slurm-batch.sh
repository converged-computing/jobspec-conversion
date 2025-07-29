#!/bin/bash
#SBATCH --job-name=RSclass
#SBATCH --output=RFclass.%N.%a.%j.out
#SBATCH --error=RFclass.%N.%a.%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=8
#SBATCH --cpus-per-task=1
#SBATCH --time=00:08:00
#SBATCH --array=772,773,876,879,908,909,910,942,943,977,981,737,773,774,806,807,808,809,810,841,842,843,844,845,877,878,880,911,912,913,914,944,945,946,947,948,976,978,979,980%4

export OPENBLAS_NUM_THREADS='1'
export MKL_NUM_THREADS='1'
export OMP_NUM_THREADS='1'

CELLS="$(($SLURM_ARRAY_TASK_ID + 3000))"
FEATMOD='base4NoPoly'
SAMPMOD='base1000'
YR=2021
STARTMO=11
MODNAME="${FEATMOD}_${SAMPMOD}_${YR}"
VARDF="/home/downspout-cel/paraguay_lc/classification/RF/pixdf_${MODNAME}.csv"
INDIR="/home/downspout-cel/paraguay_lc/stac/grids"
MODPATH="/home/downspout-cel/paraguay_lc/classification/RF/${MODNAME}_RFmod.joblib"
SINGDICT='/home/downspout-cel/paraguay_lc/singleton_var_dict.json'
MODDICT='/home/downspout-cel/paraguay_lc/Feature_Models.json'
LUT="/home/klwalker/Jupyter/LUCinSA_helpers/LUCinSA_helpers/Class_LUT.csv"
export OPENBLAS_NUM_THREADS=1
export MKL_NUM_THREADS=1
export OMP_NUM_THREADS=1
conda activate venv.lucinsa38_pipe
LUCinSA_helpers rf_classification --in_dir $INDIR --cell_list $CELLS --df_in $VARDF --feature_model $FEATMOD --start_yr $YR --start_mo $STARTMO --samp_model_name $SAMPMOD --feature_mod_dict $MODDICT --singleton_var_dict $SINGDICT --rf_mod $MODPATH  --img_out None --spec_indices None --si_vars None --spec_indices_pheno None  --pheno_vars None --singleton_vars None --poly_vars None --poly_var_path None --combo_bands None --lc_mod None --lut $LUT --importance_method None --ran_hold 0 --out_dir None --scratch_dir None
conda deactivate
