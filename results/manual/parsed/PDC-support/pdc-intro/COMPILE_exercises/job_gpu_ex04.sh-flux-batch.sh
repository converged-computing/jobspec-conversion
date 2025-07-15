#!/bin/bash
#FLUX: --job-name=fugly-taco-6868
#FLUX: --urgency=16

ml rocm/5.0.2                # Load a ROCm module
ml craype-accel-amd-gfx90a   # set the accelerator target
srun ./ex04.x > output.txt  # Run the ex04.x executable named myexe and write the output into output.txt
