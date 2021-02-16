#!/bin/bash

# Check if Q-A-Web-App and the python script is present
REPORTGENPATH="/volume/Q-A-Web-App/tools/report-gen"
REPORTGENSCRIPT="treatment-report-gen.py"
if [ ! -d "$REPORTGENPATH" ]; then
    echo "$REPORTGENPATH does not exist., exiting.."
    exit 1
fi
cd ${REPORTGENPATH}
source "${REPORTGENPATH}/reportENV/bin/activate"
./reportENV/bin/python3 ${REPORTGENSCRIPT}
deactivate
echo "Report generation is complete.."

