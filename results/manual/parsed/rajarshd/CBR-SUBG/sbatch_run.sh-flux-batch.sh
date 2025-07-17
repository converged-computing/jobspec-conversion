#!/bin/bash
#FLUX: --job-name=FreebaseQA
#FLUX: --queue=2080ti-long
#FLUX: -t=345600
#FLUX: --urgency=16

wandb agent rajarshd/cbr-weak-supervision/zdydurcs
