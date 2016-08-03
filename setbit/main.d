void main(string[] args)
{
    import std.datetime: benchmark, Duration;
    import std.stdio: writeln, writefln;
    import std.conv: to;

    ulong bitfield = 42_000;
    enum ubyte idx = 6;
    bool val = 1;

    // TODO: auto-generate
    auto f0()
    {
        import test_ctfe;
        t(bitfield);
    }

    auto f1()
    {
        import test_runtime;
        t(bitfield, idx);
    }

    auto names = ["ctfe", "runtime"];
    auto rs = benchmark!(f0, f1)(100_000_000);

    foreach(j,r;rs)
        writefln("%-8s: %s", names[j], r.to!Duration);
}
