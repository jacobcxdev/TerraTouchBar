using System;
using System.Collections.Generic;
using System.Linq;

namespace TerraTouchBar {
    public static class Utilities {
        public static IEnumerable<TResult> Map<T, TResult>(Func<ValueTuple<int, T>, TResult> func, IEnumerable<T> list) {
            foreach (ValueTuple<T, int> item in list.Select((T value, int i) => new ValueTuple<T, int>(value, i))) {
                yield return func(new ValueTuple<int, T>(item.Item2, item.Item1));
            }
        }
    }
}
