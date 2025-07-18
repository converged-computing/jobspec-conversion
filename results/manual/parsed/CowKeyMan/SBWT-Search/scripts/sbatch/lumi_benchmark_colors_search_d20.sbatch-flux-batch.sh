#!/bin/bash
#FLUX: --job-name=SBWT_colors_d20
#FLUX: --queue=standard-g
#FLUX: -t=36000
#FLUX: --urgency=16

export DATETIME='$(date +"%Y-%m-%d_%H-%M-%S_%z")'
export OUTPUT_FOLDER='colors_d20_${DATETIME}'
export LOCAL_SCRATCH='/flash/project_462000116/cauchida/colors_search_d20'
export OLD_PWD='${PWD}'
export PATH='${PWD}/cmake_dir/bin:${PATH}'

module swap craype-x86-rome craype-x86-trento
module load gcc rocm craype-accel-amd-gfx90a cray-python
unset OMP_NUM_THREADS
chmod +777 scripts/**/*
export DATETIME="$(date +"%Y-%m-%d_%H-%M-%S_%z")"
export OUTPUT_FOLDER="colors_d20_${DATETIME}"
mkdir -p "/flash/project_462000116/cauchida/colors_search_d20"
export LOCAL_SCRATCH="/flash/project_462000116/cauchida/colors_search_d20"
export OLD_PWD="${PWD}"
mkdir -p "${LOCAL_SCRATCH}/SBWT-Search/"
cd "${LOCAL_SCRATCH}/SBWT-Search"
rm -rf build
curl -O -L https://github.com/Kitware/CMake/releases/download/v3.26.3/cmake-3.26.3-linux-x86_64.tar.gz
mv cmake-* cmake.tar.gz
tar -xvf cmake.tar.gz
rm cmake.tar.gz
mv cmake-* cmake_dir
export PATH="${PWD}/cmake_dir/bin:${PATH}"
t1=$(date +%s%3N)
cp -r "${OLD_PWD}/src/" "${LOCAL_SCRATCH}/SBWT-Search/src" &
cp -r "${OLD_PWD}/cmake/" "${LOCAL_SCRATCH}/SBWT-Search/cmake" &
cp -r "${OLD_PWD}/scripts/" "${LOCAL_SCRATCH}/SBWT-Search/scripts" &
cp "${OLD_PWD}/CMakeLists.txt" "${LOCAL_SCRATCH}/SBWT-Search/CMakeLists.txt" &
wait < <(jobs -p) # wait for jobs to finish
cp -r "${OLD_PWD}/benchmark_objects/" "${LOCAL_SCRATCH}/SBWT-Search/benchmark_objects" &
bash ./scripts/build/release.sh amd >&2
wait < <(jobs -p) # wait for jobs to finish
t2=$(date +%s%3N)
mkdir -p "${OLD_PWD}/benchmark_results/${OUTPUT_FOLDER}"
echo "Time taken to copy and build in LOCAL_SCRATCH: $((t2-t1)) ms" >> "${OLD_PWD}/benchmark_results/${OUTPUT_FOLDER}/benchmark_out.txt"
bash -x scripts/benchmark/color_search_d20.sh "${OLD_PWD}/benchmark_results/${OUTPUT_FOLDER}/benchmark_out.txt" "amd"
cd "${OLD_PWD}"
rm -rf ${LOCAL_SCRATCH}
