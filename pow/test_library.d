extern(D) auto t(double a, int b)
{
    version(LDC)
    {
        import ldc.intrinsics;
        //alias pow = llvm_powi;
        alias pow = llvm_pow;
    } else {
        import std.math : pow;
    }
    return pow(a, b);
}
