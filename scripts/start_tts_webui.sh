#!/usr/bin/env bash

mkdir -p /workspace/logs
echo "Starting TTS WebUI"
export PYTHONUNBUFFERED=1
export HF_HOME="/workspace"
# Set port for the React UI
export REACT_UI_PORT=3006
VENV_PATH=$(cat /workspace/TTS-WebUI/venv_path)
source ${VENV_PATH}/bin/activate
cd /workspace/TTS-WebUI
nohup python3 server.py --docker > /workspace/logs/tts.log 2>&1 &
echo "TTS WebUI started"
echo "Log file: /workspace/logs/tts.log"
deactivate
