#!/bin/bash
#FLUX: --job-name=fft1
#FLUX: --urgency=16

. /etc/profile
module load cuda/5.0
echo "=== FFTW single thread ==="
time srun ./simple_fftw
echo
wait
