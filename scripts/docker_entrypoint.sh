#!/bin/sh
set -e # exit immediately if a command fails

export PATH=/workdir/bin:$PATH

#./scripts/build_llvm.sh
#./scripts/build_x86.sh
echo "Proving C and assembly functions"
./scripts/prove.sh
#echo "Validating Cryptol specifications"
#./scripts/check.sh | if grep False; then exit 1; fi # look for any failed checks
