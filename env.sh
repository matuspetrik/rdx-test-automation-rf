#!/usr/bin/env bash

python -m venv venv
source venv/bin/activate
pip install -r requirements.txt

export ROBOT_OPTIONS="--timestampoutputs -b debug.log -d output/  --skiponfailure NONCRIT --output html/output --report html/report --log html/log"
