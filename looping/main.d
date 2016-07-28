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

    // TODO: auto-generate
    auto f0()
    {
        import test_random_access;
        return t(arr);
    }
    auto f1()
    {
        import test_foreach;
        return t(arr);
    }
    auto f2()
    {
        import test_foreach_ref;
        return t(arr);
    }
    auto f3()
    {
        import test_for;
        return t(arr);
    }

    auto names = ["random_acc.", "foreach", "foreach_ref", "for"];
    auto rs = benchmark!(f0, f1, f2, f3)(5_000);

    foreach(j,r;rs)
        writefln("%-12s: %s", names[j], r.to!Duration);
}
