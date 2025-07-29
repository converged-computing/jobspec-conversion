#!/bin/bash
#FLUX: --job-name=popart-ibm
#FLUX: --queue=short
#FLUX: --urgency=16

module unload GSL
module load GSL/2.6-GCC-8.3.0
module load intel
starting_run=1
number_of_runs=1000
number_of_sims=28
input_dir="/well/fraser/users/zkv138/PARAMETERS/POSTERIORS"
for community in {1..12}; do
        $(pwd)/popart-simul.exe ${input_dir}/PARAMS_COMMUNITY${community}_ACCEPTED $number_of_runs 0 $starting_run $number_of_sims $input_dir/Outputs
done
rm ${input_dir}/Outputs/CHIPS*
rm ${input_dir}/Outputs/Annual*
