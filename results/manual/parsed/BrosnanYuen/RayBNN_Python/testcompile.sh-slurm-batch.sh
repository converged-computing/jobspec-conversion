#!/bin/bash
#SBATCH --job-name=arrayfire
#SBATCH --account=def-taolu
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=6
#SBATCH --mem=16G
#SBATCH --time=00:00:14

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
