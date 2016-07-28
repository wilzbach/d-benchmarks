alias R = int[];
auto t(R)(R r)
{
    auto sum = 0;
    foreach (const el; r)
    {
        sum += el;
    }
    return sum;
}
