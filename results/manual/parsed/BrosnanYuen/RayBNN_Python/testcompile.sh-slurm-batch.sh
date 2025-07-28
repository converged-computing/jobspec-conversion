#!/bin/bash
#FLUX: --job-name=arrayfire
#FLUX: -c=6
#FLUX: -t=14
#FLUX: --urgency=16

module --force purge
module load StdEnv/2020 gcc/9.3.0 cuda/12.2 fmt/9.1.0 spdlog/1.9.2 arrayfire/3.9.0 rust/1.70.0 python/3.11.2 openblas
nvidia-smi
cd /scratch/brosnany/
source /scratch/brosnany/magic/bin/activate
rm -rf /scratch/brosnany/Rust_Code/target/
cd /scratch/brosnany/Rust_Code
pip install maturin numpy patchelf
maturin develop
python3 ./example.py
python3 ./run_network.py
rm -rf /scratch/brosnany/Rust_Code/target/
maturin build -r
