; n = 5
;                    {A B C D E} 31
;                    /       \
;            {A B C D} 15     E 16
;            /    \
;      {A B C} 7   D 8
;      /    \
;  {A B} 3   C 4
;  /   \
; A 1   B 2

; n = 10
;                                                         {A B C D E F G H I J} 1023
;                                                         /                 \
;                                               {A B C D E F G H I} 511      J 512
;                                               /                \
;                                       {A B C D E F G H} 255     I 256
;                                       /              \
;                               {A B C D E F G} 127     H 128
;                                /            \
;                          {A B C D E F} 63    G 64
;                          /           \
;                    {A B C D E} 31     F 32
;                    /       \
;            {A B C D} 15     E 16
;            /    \
;      {A B C} 7   D 8
;      /    \
;  {A B} 3   C 4
;  /   \
; A 1   B 2

; In such a tree (for general `n'), `1' bit is required to encoded the most
; frequent symbol and `n - 1' bits are required to encoded the least frequent
; symbol.
