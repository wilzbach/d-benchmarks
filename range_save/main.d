void main(string[] args)
{
    import std.datetime : benchmark, Duration;
    import std.stdio : writeln, writefln;
    import std.conv : to;

    import std.random : randomShuffle;
    import std.range : iota;
    import std.array : array;
    auto arr = iota(100_000).array;
    arr.randomShuffle;
    import std.range;
    auto needle = arr[arr.length / 2];

    import std.exception;
    auto check(size_t el)
    {
        enforce(el == needle);
    }

    // TODO: auto-generate
    void f0()
    {
        import test_random_access;
        check(m(arr, needle).front);
    }
    void f1()
    {
        import test_foreach;
        check(m(arr, needle).front);
    }
    void f2()
    {
        import test_for;
        check(m(arr, needle).front);
    }

    auto names = ["random", "foreach", "for"];
    auto rs = benchmark!(f0, f1, f2)(5_000);

    foreach(j,r;rs)
        writefln("%-8s: %s", names[j], r.to!Duration);
}

