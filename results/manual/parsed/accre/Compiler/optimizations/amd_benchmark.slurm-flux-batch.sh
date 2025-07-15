#!/bin/bash
#FLUX: --job-name=nerdy-dog-4785
#FLUX: -t=900
#FLUX: --urgency=16

echo "   "
echo "Running on node: " $SLURM_NODELIST
echo "   "
echo "   "
echo "   "
echo "Running gcc_loop..."
echo " "
time ./gcc_loop
echo " "
echo "Running gcc_loop_O3..."
echo " "
time ./gcc_loop_O3
echo " "
echo "Running gcc_powern..."
echo " "
time ./gcc_powern
echo " "
echo "Running gcc_powern_O3..."
echo " "
time ./gcc_powern_O3
echo " "
echo "Running intel_loop..."
echo " "
time ./intel_loop
echo " "
echo "Running intel_loop_O3..."
echo " "
time ./intel_loop_O3
echo " "
echo "Running intel_powern..."
echo " "
time ./intel_powern
echo " "
echo "Running intel_powern_O3..."
echo " "
time ./intel_powern_O3
echo " "
