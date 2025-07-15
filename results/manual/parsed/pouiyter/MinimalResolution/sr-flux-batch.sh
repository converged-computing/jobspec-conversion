#!/bin/bash
#FLUX: --job-name=expressive-bike-0197
#FLUX: -c=127
#FLUX: --priority=16

./mr_st 35 36
./BPtab 35
./mr_BP 35 35
