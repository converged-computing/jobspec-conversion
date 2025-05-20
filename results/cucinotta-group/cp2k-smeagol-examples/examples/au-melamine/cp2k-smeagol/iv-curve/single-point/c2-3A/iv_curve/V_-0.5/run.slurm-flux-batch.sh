#!/bin/bash
#flux: -N 8
#flux: -n 256
#flux: -c 2
#flux: --mem-per-cpu=3200M # Assuming 200GiB/node: (200 * 1024 MiB) / 64 cpus/node = 3200 MiB/cpu
#flux: -t 01:00:00
#flux: -o job.out.%J
#flux: -e job.err.%J

# Change to submission directory (