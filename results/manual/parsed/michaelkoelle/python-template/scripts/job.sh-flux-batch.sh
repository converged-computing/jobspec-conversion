#!/bin/bash
#FLUX: --job-name=blank-sundae-5788
#FLUX: --queue=All
#FLUX: --urgency=16

export WANDB_SILENT='true'

export WANDB_SILENT="true"
if command -v pyenv 1>/dev/null 2>&1; then
    # Setup pyenv shell
    eval "$(pyenv init --path)"
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
    # Create a fresh virtual environment
    pyenv virtualenv env 1>/dev/null 2>&1
    pyenv activate env 1>/dev/null 2>&1
    # Check the exit status of the pyenv activate command
    if [ $? -ne 0 ]; then
        echo "\033[31mFailed to activate the virtual environment using pyenv. Exiting.\033[0m"
        exit 1
    fi
elif command -v virtualenv 1>/dev/null 2>&1; then
    # Create a fresh virtual environment using virtualenv
    virtualenv env
    source env/bin/activate
    # Check the exit status of the virtual environment activation
    if [ $? -ne 0 ]; then
        echo "\033[31mFailed to activate the virtual environment using virtualenv. Exiting.\033[0m"
        exit 1
    fi
else
    echo "\033[31mNeither pyenv nor virtualenv are available. Exiting.\033[0m"
    exit 1
fi
pip install -qr requirements.txt
python src/main.py $@
