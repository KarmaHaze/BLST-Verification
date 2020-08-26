#!/bin/sh

set -e

Z3_URL='https://github.com/Z3Prover/z3/releases/download/z3-4.8.8/z3-4.8.8-x64-ubuntu-16.04.zip'
YICES_URL='https://yices.csl.sri.com/releases/2.6.2/yices-2.6.2-x86_64-pc-linux-gnu-static-gmp.tar.gz'

# Determine the URL of the latest SAW and Cryptol nightly
#########################################################

SAW_DATE=$(curl -s https://saw.galois.com/builds/nightly/ | grep saw | grep -o "[0-9]\{4\}-[0-9]\{2\}-[0-9]\{2\}" | sort | tail -n 1) # `grep -o` says print only the matched substring
SAW_NIGHTLY=$(curl -s https://saw.galois.com/builds/nightly/ | grep -oP "saw.*?${SAW_DATE}-Ubuntu.*?\.tar\.gz"  | head -n 1) # `curl -s` means silent; `grep -o` says print only the matched substring; `grep -P` says Perl syntax, which we use to get a lazy match (shortest) with .*?
SAW_URL="https://saw.galois.com/builds/nightly/${SAW_NIGHTLY}"

CRYPTOL_DATE=$(curl -s https://cryptol.net/builds/nightly/ | grep cryptol | grep -o "[0-9]\{4\}-[0-9]\{2\}-[0-9]\{2\}" | sort | tail -n 1) # `grep -o` says print only the matched substring
CRYPTOL_NIGHTLY=$(curl -s https://cryptol.net/builds/nightly/ | grep -oP "cryptol.*?${CRYPTOL_DATE}-Ubuntu.*?\.tar\.gz"  | head -n 1) # `curl -s` means silent; `grep -o` says print only the matched substring; `grep -P` says Perl syntax, which we use to get a lazy match (shortest) with .*?
CRYPTOL_URL="https://cryptol.net/builds/nightly/${CRYPTOL_NIGHTLY}"

# Install Z3, Yices, SAW, and Cryptol
#####################################

mkdir -p bin deps

# fetch Z3
if [ ! -f bin/z3 ]
then
    mkdir -p deps/z3
    wget $Z3_URL -O deps/z3.zip
    unzip deps/z3.zip -d deps/z3
    cp deps/z3/*/bin/z3 bin/z3
fi

# fetch Yices
if [ ! -f bin/yices ]
then
    mkdir -p deps/yices
    wget $YICES_URL -O deps/yices.tar.gz
    tar -x -f deps/yices.tar.gz --one-top-level=deps/yices
    cp deps/yices/*/bin/yices bin/yices
    cp deps/yices/*/bin/yices-smt2 bin/yices-smt2
fi

# fetch SAW
if [ ! -f bin/saw ]
then
    mkdir -p deps/saw
    wget $SAW_URL -O deps/saw.tar.gz
    tar -x -f deps/saw.tar.gz --one-top-level=deps/saw
    cp deps/saw/*/bin/saw bin/saw
fi

# fetch Cryptol
if [ ! -f bin/cryptol ]
then
    mkdir -p deps/cryptol
    wget $CRYPTOL_URL -O deps/cryptol.tar.gz
    tar -x -f deps/cryptol.tar.gz --one-top-level=deps/cryptol
    cp deps/cryptol/*/bin/cryptol bin/cryptol
fi
