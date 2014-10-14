; The most expensive part of the operation is to search the symbol list while
; encountering each node.
; The number of steps required for searching an unordered list of `n' elements
; is `O(n)'.
; Considering the special case in exercise `2.71', when encoding the most
; frequent symbol, we need to go down one time and thus the order of growth
; is `O(n). When encoding the least frequent symbol, we need to go down `O(n)'
; times and therefore the order of growth is `O(n^2)'.
