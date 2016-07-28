auto m(R)(R r, size_t needle)
{
    foreach (i, const el; r)
    {
        if (el == needle)
            return r[i .. $];
    }
    return r;
}
