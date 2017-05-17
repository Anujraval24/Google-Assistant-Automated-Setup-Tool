#!/bin/bash
python_environment=$(locate -n 1 /env/bin/activate)
source $python_environment
python -m googlesamples.assistant