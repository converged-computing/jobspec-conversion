#!/bin/bash
#FLUX: --job-name=boopy-soup-7291
#FLUX: --priority=16

export LD_LIBRARY_PATH='$HOME/lib:$HOME/lib64'
export PKG_CONFIG_PATH='$HOME/lib/pkgconfig:$HOME/lib64/pkgconfig'

unset -v GMON_OUT_PREFIX
export LD_LIBRARY_PATH="$HOME/lib:$HOME/lib64"
export PKG_CONFIG_PATH="$HOME/lib/pkgconfig:$HOME/lib64/pkgconfig"
index=${SLURM_ARRAY_TASK_ID}
scratch_root="$HOME"
subject='ffmpeg'
declare -a branches=(
    "0.5.0" "0.6.0" "0.7.0" "0.8.0" "0.9.0" "0.10.0" "0.11.0" "1.0.0"
    "1.1.0" "1.2.0" "2.0.0" "2.1.0" "2.2.0" "2.3.0" "2.4.0" "2.5.0"
)
declare -a releases=(
    "0.5.0" "0.6.0" "0.7.0" "0.8.0" "0.9.0" "0.10.0" "0.11.0" "1.0.0"
    "1.1.0" "1.2.0" "2.0.0" "2.1.0" "2.2.0" "2.3.0" "2.4.0" "2.5.0"
)
if [ "$#" -eq 1 ]; then
    SLURM_ARRAY_TASK_ID=$1
    echo "Running manual script for release ${releases[${index}]}"
fi
branch=${branches[${index}]}
release=${releases[${index}]}
cd "$scratch_root/$subject/b${branch}/v${release}"
mkdir gprof
cd "$scratch_root/$subject/b${branch}/v${release}/src"
mkdir gmon
if [ "$release" == "0.6.0" ]
then
    cp -r "$scratch_root/$subject/b0.7.0/v0.7.0/src/fate-suite/" .
fi
curl https://5751f28e22fbde2d8ba3f9b75936e0767c761c6a.googledrive.com/host/0B1eWsh8KZjRrfjg0Z1VkcU96U2hQal9scHM3NzVmYTk2WVhiQzQtdGFpNWc5c0VzbUJFTE0/$subject/patches/$release.patch > patch.patch
git apply patch.patch
rm patch.patch
if [ "$release" == "0.5.0" ]
then
    make test --ignore-errors
else
    make fate --ignore-errors
fi
