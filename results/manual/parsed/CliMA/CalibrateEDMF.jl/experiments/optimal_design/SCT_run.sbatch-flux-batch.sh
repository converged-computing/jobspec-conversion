#!/bin/bash
#FLUX: --job-name=hadgem
#FLUX: -n=10
#FLUX: -t=7200
#FLUX: --urgency=16

module load julia/1.10.1
julia --project -e 'using Pkg; Pkg.instantiate(); Pkg.API.precompile()'
exp_dir=/groups/esm/ilopezgo/CalibrateEDMF.jl/experiments/optimal_design/global_parallel/
method=last_nn_particle_mean
experiment=results_Inversion_dt_1.0_p2_e50_i10_d40_LES_2022-07-13_22-31_ewR
out_name=perf_model_HadGEM2_nz55_B38_Inv_d40_p2_ewR
tc_runner_path=../../tools/
test_data_config=../experiments/optimal_design/hadgem_amip_sct_config.jl
tc_runner=TCRunner.jl
julia -p10 $tc_runner_path$tc_runner --results_dir=$exp_dir$experiment --tc_output_dir=$out_name --method=$method --run_set="test" --run_set_config=$test_data_config
cp $tc_runner_path$test_data_config $out_name/data_generator_config.jl
cp $exp_dir$experiment/config.jl $out_name/calibrated_model_config.jl
