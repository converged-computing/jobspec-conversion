#!/bin/bash
#FLUX: --job-name=SBWT_themisto_d20
#FLUX: --queue=standard-g
#FLUX: -t=10800
#FLUX: --priority=16

export DATETIME='$(date +"%Y-%m-%d_%H-%M-%S_%z")'
export OUTPUT_FOLDER='themisto{DATETIME}'
export LOCAL_SCRATCH='/flash/project_462000116/cauchida/themisto_d20'
export OLD_PWD='${PWD}'
export THEMISTO_VERSION='3.1.2'
export THEMISTO_FOLDER='themisto_linux-v${THEMISTO_VERSION}'

module swap craype-x86-rome craype-x86-trento
module load gcc rocm craype-accel-amd-gfx90a cray-python
unset OMP_NUM_THREADS
chmod +777 scripts/**/*
export DATETIME="$(date +"%Y-%m-%d_%H-%M-%S_%z")"
export OUTPUT_FOLDER="themisto{DATETIME}"
mkdir -p "/flash/project_462000116/cauchida/themisto_d20"
export LOCAL_SCRATCH="/flash/project_462000116/cauchida/themisto_d20"
export OLD_PWD="${PWD}"
mkdir -p "${LOCAL_SCRATCH}/SBWT-Search/"
cd "${LOCAL_SCRATCH}/SBWT-Search"
rm -rf build
t1=$(date +%s%3N)
cp -r "${OLD_PWD}/benchmark_objects/" "${LOCAL_SCRATCH}/SBWT-Search/benchmark_objects"
t2=$(date +%s%3N)
echo "Time taken to copy and build in LOCAL_SCRATCH: $((t2-t1)) ms"
cd benchmark_objects
export THEMISTO_VERSION="3.1.2"
export THEMISTO_FOLDER="themisto_linux-v${THEMISTO_VERSION}"
curl -O -L https://github.com/algbio/themisto/releases/download/v${THEMISTO_VERSION}/${THEMISTO_FOLDER}.tar.gz
tar -xvzf ${THEMISTO_FOLDER}.tar.gz
rm ${THEMISTO_FOLDER}.tar.gz
mv ${THEMISTO_FOLDER} themisto
cd ..
mkdir -p themisto_temp
cp benchmark_objects/index/index_d20.tcolors benchmark_objects/index/index.tcolors
./benchmark_objects/themisto/themisto pseudoalign \
  --n-threads 128 \
  --sort-output \
  --temp-dir themisto_temp \
  --out-file-list benchmark_objects/list_files/output/color_search_results_running.list \
  --query-file-list benchmark_objects/list_files/input/unzipped_seqs.list \
  --index-prefix benchmark_objects/index/index \
  --verbose \
  --threshold 0.7
cd "${OLD_PWD}"
rm -rf ${LOCAL_SCRATCH}
