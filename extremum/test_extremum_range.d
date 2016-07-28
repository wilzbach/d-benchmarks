import std.range;
import std.traits;
import std.functional: unaryFun, binaryFun;

extern(D) auto m(alias map = "a", alias selector = "a < b", Range,
                      RangeElementType = ElementType!Range)
                     (Range r, RangeElementType seedElement)
    if (isInputRange!Range && !isInfinite!Range &&
        !is(CommonType!(ElementType!Range, RangeElementType) == void))
{

    alias mapFun = unaryFun!map;
    alias selectorFun = binaryFun!selector;

    alias Element = ElementType!Range;
    alias CommonElement = CommonType!(Element, RangeElementType);
    alias MapType = Unqual!(typeof(mapFun(CommonElement.init)));

    Unqual!CommonElement extremeElement = seedElement;
    MapType extremeElementMapped = mapFun(extremeElement);

    while (!r.empty)
    {
        MapType mapElement = mapFun(r.front);
        if (selectorFun(mapElement, extremeElementMapped))
        {
            extremeElement = r.front;
            extremeElementMapped = mapElement;
        }
        r.popFront();
    }
    return extremeElement;
}
