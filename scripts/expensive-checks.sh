#!/bin/bash

# Validations checks that are long-running and with a big memory footprint.
# See the comments in `checks.sh`.

cryptol <<EOF
:set tests=100
:l tests/PairingTest.cry
:check
EOF
