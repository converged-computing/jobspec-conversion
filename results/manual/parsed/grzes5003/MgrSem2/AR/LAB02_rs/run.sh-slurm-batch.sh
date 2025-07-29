#!/bin/bash
#FLUX: --job-name=MPISieve_rs
#FLUX: --queue=plgrid
#FLUX: -t=300
#FLUX: --urgency=16

if [ -z "$SCRIPT" ]; then
  TODAY=$(date +"%d_%H_%M")
  exec 3>&1 4>&2
  trap 'exec 2>&4 1>&3' 0 1 2 3
  exec 1>log_"$TODAY".log 2>&1
fi
module load rust/1.63.0-gcccore-10.3.0
module load openmpi/4.1.2-intel-compilers-2021.4.0
module load clang
echo "Compiling LAB02"
cargo update
cargo build --release
echo "Starting LAB02"
mpiexec -np 4 ./target/release/LAB02 10000
