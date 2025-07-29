#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=20
#SBATCH --gres=gpu:1
#SBATCH --mem=40G
#SBATCH --time=01:00:00
#SBATCH --partition=build
#SBATCH --qos=gpu

SCRIPT=$(realpath "$0")
SCRIPT_DIR=$(dirname "$SCRIPT")
source $SCRIPT_DIR/bluebild.sh
STACK=gcc
if [[ $1 == "--full" ]]; then
    echo "-I- full installation requested"
    time bb_create_python_venv $STACK
    time bb_install_ninja
    time bb_install_finufft $STACK
    time bb_install_cufinufft $STACK
    time bb_install_imot_tools $STACK
    time bb_install_marla
else
    echo "-I- partial installation requested: will only install bluebild and pypeline"
fi
time bb_install_bluebild $STACK
time bb_install_pypeline $STACK
