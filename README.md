Benchmarking
============

Assuming you have a folder 'alias' with the following test files:

```
looping/
	main.d      (benchmark evaluator)
	test_1.d    (provides a test, must be annotated with `extern`)
	test_2.d
	...
```

it then provides the following targets

```
make looping.dmd
make looping.ldc
make looping.all
```

Other targets
-------------

```
make all     (will run all targets)
make clean   (removes all binaries)
```

Assembler files
---------------

This only works for non-templated functions!

```
make bin/dmd/looping/test_foreach.s
make bin/ldc/looping/test_foreach.s
```

Libraries
---------

Libraries can be added to the compilation process too, however this isn't
integrated yet into the build process.
