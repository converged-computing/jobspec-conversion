#!/bin/bash
#FLUX: --job-name=MySerialJob
#FLUX: --queue=gpu
#FLUX: -t=300
#FLUX: --urgency=16

EXAMPLE_VARIABLE="Hello!"
echo $EXAMPLE_VARIABLE
