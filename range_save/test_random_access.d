auto m(R)(R r, size_t needle)
{
    foreach (const i; 0 .. r.length)
    {
        if (r[i] == needle)
            return r[i .. $];
    }
    return r[$ .. $];
}
