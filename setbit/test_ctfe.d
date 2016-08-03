auto t(ulong bitfield)
{
    // we can't use templates in main file
    return h!6(bitfield);
}

auto h(ubyte idx)(ulong bitfield)
{
    enum mask = 1UL << idx;
    return bitfield |= mask;
}
