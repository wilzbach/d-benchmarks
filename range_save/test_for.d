import std.range;

auto m(R)(R r, size_t needle)
{
    for (; !r.empty; r.popFront())
    {
        if (r.front == needle)
            return r; // note in std.algorithm `save` is used
    }
    return r;
}
