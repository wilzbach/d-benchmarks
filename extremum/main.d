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

    // TODO: auto-generate
    void f0()
    {
        import test_extremum_range;
        m(arr, 0);
    }
    void f1()
    {
        import test_extremum_random;
        m(arr, 0);
    }

    auto names = ["range", "random"];
    auto rs = benchmark!(f0, f1)(5_000);

    foreach(j,r;rs)
        writefln("%-8s: %s", names[j], r.to!Duration);
}
