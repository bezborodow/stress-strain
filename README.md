# `stress.m` Stress-strain Plotter

## Prerequisites

```
sudo apt install octave-statistics octave-matgeom
```

This utility will graph a stress-strain plot with [GNU Octave](https://octave.org/).

## Usage

An example plot will give the following output.

```
$ octave-cli stress.m examples/St1594.csv
St1594
E = 159.5514e+009
y =

     4.0547e-03   327.8306e+00

UTS = 497.0183e+000
Ur = 336.7970e+003
Ut = 176.4531e+006
UrA = 976.8397e+003
Ury = 664.6275e+003
```

**E** = modulus of elasticity, **y** = yield point, **UTS** = ultimate tensile strength (MPa), **Ur** = resilience, **Ut** = toughness, **UrA** = resilience calculated by area using [`trapz`](https://au.mathworks.com/help/matlab/ref/trapz.html), **Ury**, resilience calculated by yield point.

A stress strain curve will be plotted:

![St1594 stress-strain](https://raw.githubusercontent.com/bezborodow/stress-strain/main/examples/St1594.svg)

Additionally, a subplot of the linear region will provide greater detail of the elastic properties of the material:

![St1594 stress-strain (linear region)](https://raw.githubusercontent.com/bezborodow/stress-strain/main/examples/St1594_1.svg)
