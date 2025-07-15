#!/bin/bash
#FLUX: --job-name=fugly-platanos-8647
#FLUX: -t=1200
#FLUX: --priority=16

srun iperf -s
