#!/bin/bash
#FLUX: --job-name=install-pennylane+qiskit-source-rocm-setonix
#FLUX: --exclusive
#FLUX: --queue=gpu-dev
#FLUX: -t=1800
#FLUX: --priority=16

script_dir="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
. $script_dir/use-pennylane+qiskit-source-rocm-setonix.sh
git clone https://github.com/Qiskit/qiskit-aer $source_dir/qiskit-aer
cd $source_dir/qiskit-aer
git checkout $aer_ver
pip install --prefix=$install_dir -r requirements-dev.txt
pip install --prefix=$install_dir pybind11[global]
python ./setup.py bdist_wheel -- \
  -DCMAKE_CXX_COMPILER=hipcc \
  -DCMAKE_BUILD_TYPE=Release \
  -DAER_MPI=True \
  -DAER_THRUST_BACKEND=ROCM \
  -DAER_ROCM_ARCH=gfx90a \
  -DAER_DISABLE_GDR=False \
  --
pip install --prefix=$install_dir dist/qiskit_aer*.whl
cd -
pip install --prefix="$install_dir" \
  pennylane=="$pl_ver" \
  pennylane-lightning=="$pl_ver" \
  pennylane-qiskit=="$pl_ver"
