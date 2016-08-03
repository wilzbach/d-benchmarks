extern(D) ulong t(ulong bitfield, ulong idx)
{
    ulong value = cast(ulong) bitfield;
    ulong mask = 1UL << idx;
    return value |= mask;
}
