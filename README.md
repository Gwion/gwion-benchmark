# gwion-benchmark

Tools to run a benchmark of Gwion compared to other languages.
Find the [latest results here](https://gwion.github.io/Gwion/Benchmarks.html).

# Contributing

To add extra languages to the benchmarks follow these easy steps.

- Fork and clone this repository
- Setup all of the required tests in the `src/` directory written in the language you wish to add
- In [build.yml](.github/workflows/build.yml) add the build steps for the language
- In [benchmark.sh](benchmark.sh) add the language along with the language file extension to the two relevant arrays at the top of the file
- In [version.sh](version.sh) add the version of the language which is being benchmarked
