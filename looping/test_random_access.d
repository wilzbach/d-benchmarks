alias R = int[];
auto t(R)(R r)
{
    auto sum = 0;
    foreach (const i; 0 .. r.length)
    {
        sum += r[i];
    }
    return sum;
}
