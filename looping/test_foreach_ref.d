alias R = int[];
auto t(R)(R r)
{
    auto sum = 0;
    foreach (const ref el; r)
    {
        sum += el;
    }
    return sum;
}
