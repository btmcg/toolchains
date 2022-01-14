#!/bin/sh

set -o nounset
set -o errexit

> build_times
printf "gcc-11.2.0: " >> build_times
/usr/bin/time --append --format=%E --output=build_times ./10-gcc-11.2.0.sh

printf "clang-13.0.0: " >> build_times
/usr/bin/time --append --format=%E --output=build_times ./20-clang-13.0.0.sh
