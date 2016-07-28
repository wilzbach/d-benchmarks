void main(string[] args)
{
    import std.datetime: benchmark, Duration;
    import std.stdio: writeln, writefln;
    import std.conv: to;

    auto a = 5.0;
    auto b = 25;

    // TODO: auto-generate
    auto f0()
    {
        import test_builtin;
        return t(a, b);
    }
    auto f1()
    {
        import test_library;
        return t(a, b);
    }

    auto names = ["builtin", "library"];
    auto rs = benchmark!(f0, f1)(10_000_000);

    foreach(j,r;rs)
        writefln("%-8s: %s", names[j], r.to!Duration);
}
