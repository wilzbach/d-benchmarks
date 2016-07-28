alias R = int[];
auto t(R)(R r)
{
    import std.range;
    auto sum = 0;
    for (; !r.empty; r.popFront())
    {
        sum += r.front;
    }
    return sum;
}
