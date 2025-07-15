#!/bin/bash
#FLUX: --job-name=buildBpreveal
#FLUX: -n=3
#FLUX: --queue=gpu
#FLUX: -t=3600
#FLUX: --urgency=16

export BPREVEAL_KILL_LD_LIB_PATH='\$pathAccum'
export LD_LIBRARY_PATH='\${pathAccum}\${LD_LIBRARY_PATH}'

source /home/cm2363/.zshrc
BPREVEAL_DIR=/n/projects/cm2363/bpreveal
ENV_FLAG=-n
ENV_NAME=bpreveal-cerebro
CONDA_BIN=mamba
PIP_BIN=pip
INSTALL_JUPYTER=true
INSTALL_DEVTOOLS=true
INSTALL_PYDOT=true
conda deactivate # In case the user forgot.
PYTHON_VERSION=3.12
runAndCheck() {
    currentCommand=$@
    echo "EXECUTING COMMAND: [[$currentCommand]]"
    eval "$currentCommand"
    errorVal=$?
    if [ $errorVal -eq 0 ]; then
        echo "SUCCESSFULLY EXECUTED: [[$currentCommand]]"
    else
        echo "ERROR DETECTED: Command [[$currentCommand]] on line $BASH_LINENO exited with status $errorVal"
        exit 1
    fi
}
check() {
    errorVal=$?
    if [ $errorVal -eq 0 ]; then
        echo "Command completed successfully"
    else
        echo "ERROR DETECTED: Command $@ exited with status $errorVal"
        exit
    fi
}
checkPackage() {
    python3 -c "import $1"
    errorVal=$?
    if [ $errorVal -eq 0 ]; then
        echo "$1 imported successfully."
    else
        echo "ERROR DETECTED: Failed to import $1"
        exit
    fi
}
runAndCheck ${CONDA_BIN} create --yes ${ENV_FLAG} ${ENV_NAME} python=${PYTHON_VERSION}
runAndCheck conda activate ${ENV_NAME}
runAndCheck python3 --version \| grep -q "${PYTHON_VERSION}"
${PIP_BIN} install 'tensorflow[and-cuda]'
check install tensorflow
runAndCheck ${PIP_BIN} install 'tensorflow-probability'
checkPackage tensorflow
checkPackage tensorflow_probability
runAndCheck ${PIP_BIN} install 'tf-keras~=2.16'
runAndCheck ${CONDA_BIN} install --yes -c conda-forge matplotlib
checkPackage matplotlib
runAndCheck ${CONDA_BIN} install --yes -c conda-forge jsonschema
checkPackage jsonschema
runAndCheck ${CONDA_BIN} install --yes -c conda-forge cmake
runAndCheck ${CONDA_BIN} install --yes -c conda-forge h5py
checkPackage h5py
runAndCheck ${CONDA_BIN} install --yes -c conda-forge tqdm
checkPackage tqdm
runAndCheck ${CONDA_BIN} install --yes -c conda-forge gxx_linux-64
runAndCheck ${CONDA_BIN} install --yes -c bioconda bedtools
runAndCheck ${PIP_BIN} install --no-input pysam pybedtools pybigwig
checkPackage pybedtools
checkPackage pyBigWig
checkPackage pysam
runAndCheck ${PIP_BIN} install --no-input modisco-lite
if [ "$INSTALL_JUPYTER" = true ] ; then
    runAndCheck ${CONDA_BIN} install --yes -c conda-forge jupyterlab pandoc
fi
if [ "$INSTALL_DEVTOOLS" = true ] ; then
    runAndCheck ${CONDA_BIN} install --yes -c conda-forge flake8 pydocstyle \
        pylint sphinx sphinx_rtd_theme sphinx-argparse sphinx-autodoc-typehints coverage
fi
if [ "$INSTALL_PYDOT" = true ] ; then
    runAndCheck ${CONDA_BIN} install --yes -c conda-forge graphviz pydot
fi
runAndCheck ${CONDA_BIN} install --yes -c conda-forge gfortran meson
cd ${BPREVEAL_DIR}/src && make clean && make
check
runAndCheck ${CONDA_BIN} install --yes -c conda-forge conda-build
runAndCheck conda develop ${BPREVEAL_DIR}/pkg
echo "export BPREVEAL_KILL_PATH=${BPREVEAL_DIR}/bin"\
    > ${CONDA_PREFIX}/etc/conda/activate.d/bpreveal_bin_activate.sh
echo "export PATH=\$BPREVEAL_KILL_PATH:\$PATH"\
    >> ${CONDA_PREFIX}/etc/conda/activate.d/bpreveal_bin_activate.sh
echo "export XLA_FLAGS=\"--xla_gpu_cuda_data_dir=${CONDA_PREFIX}\"" \
    > ${CONDA_PREFIX}/etc/conda/activate.d/cuda_xla_activate.sh
cat >>  ${CONDA_PREFIX}/etc/conda/activate.d/cuda_xla_activate.sh << EOF
NVIDIA_DIR=\$(dirname \$(dirname \$(python -c "import nvidia.cudnn; print(nvidia.cudnn.__file__)")))
pathAccum=""
for dir in \$NVIDIA_DIR/*; do
    if [ -d "\$dir/lib" ]; then
        pathAccum="\$dir/lib:\$pathAccum"
    fi
done
export BPREVEAL_KILL_LD_LIB_PATH=\$pathAccum
export LD_LIBRARY_PATH="\${pathAccum}\${LD_LIBRARY_PATH}"
EOF
echo "export TF_USE_LEGACY_KERAS=1" \
    > ${CONDA_PREFIX}/etc/conda/activate.d/legacy_keras_activate.sh
echo "export PATH=\$(echo \$PATH | tr ':' '\n' | grep -v \$BPREVEAL_KILL_PATH | tr '\n' ':')"\
    > ${CONDA_PREFIX}/etc/conda/deactivate.d/bpreveal_bin_deactivate.sh
echo "unset BPREVEAL_KILL_PATH"\
    >> ${CONDA_PREFIX}/etc/conda/deactivate.d/bpreveal_bin_deactivate.sh
echo "unset XLA_FLAGS" \
    > ${CONDA_PREFIX}/etc/conda/deactivate.d/cuda_xla_deactivate.sh
echo '\nexport LD_LIBRARY_PATH=$(echo $LD_LIBRARY_PATH | sed "s|$BPREVEAL_KILL_LD_LIB_PATH||" )'\
    >> ${CONDA_PREFIX}/etc/conda/deactivate.d/cuda_xla_deactivate.sh
echo "unset TF_USE_LEGACY_KERAS" \
    > ${CONDA_PREFIX}/etc/conda/deactivate.d/legacy_keras_deactivate.sh
echo "*-----------------------------------*"
echo "| BPReveal installation successful. |"
echo "|           (probably...)           |"
echo "*-----------------------------------*"
