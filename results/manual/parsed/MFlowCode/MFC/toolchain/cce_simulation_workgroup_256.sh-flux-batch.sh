#!/bin/bash
#FLUX: --job-name=fuzzy-destiny-2178
#FLUX: --priority=16

CCE_LLVM_PATH=${CRAY_CCE_CLANGSHARE}/../
WGSIZE=256
echo "Disassembling"
${CCE_LLVM_PATH}/bin/llvm-dis "$1/simulation-cce-openmp-pre-llc.bc"
echo "Globally setting amdgpu-flat-work-group-size size to 1,$WGSIZE"
sed "s/\"amdgpu-flat-work-group-size\"\=\"1,1024\"/\"amdgpu-flat-work-group-size\"\=\"1,${WGSIZE}\"/g" "$1/simulation-cce-openmp-pre-llc.ll" > "$1/simulation-cce-openmp-pre-llc-wg${WGSIZE}.ll"
echo "Invoking LLC to compile"
${CCE_LLVM_PATH}/bin/llc -mtriple=amdgcn-amd-amdhsa -disable-promote-alloca-to-lds -mcpu=gfx90a -amdgpu-dump-hsa-metadata "$1/simulation-cce-openmp-pre-llc-wg${WGSIZE}.ll" -filetype=obj -o "$1/simulation-cce-openmp__llc_wg${WGSIZE}.amdgpu"
echo "Linking to a CCE Offload module"
${CCE_LLVM_PATH}/bin/lld  -flavor gnu --no-undefined -shared -o "$1/simulation-wg${WGSIZE}.lld.exe" "$1/simulation-cce-openmp__llc_wg${WGSIZE}.amdgpu"
echo "Now "
echo "export CRAY_ACC_MODULE=${PWD}/build/simulation/simulation-wg${WGSIZE}.lld.exe"
echo "to use the new GPU offload code."
echo "To use the original build"
echo "unset CRAY_ACC_MODULE"
