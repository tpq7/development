|    Precedence    |     Operator     |                        Description                       |   Associativity  |
|:----------------:|:----------------:|:--------------------------------------------------------:|:----------------:|
|                  |                  |                                                          |                  |
|         1        |       ++ --      |          Suffix/postfix increment and decrement          |   Left-to-right  |
|         1        |        ()        |                       Function call                      |   Left-to-right  |
|         1        |        []        |                    Array subscripting                    |   Left-to-right  |
|         1        |         .        |             Structure and union member access            |   Left-to-right  |
|         1        |        ->        |     Structure and union member access through pointer    |   Left-to-right  |
|         1        |   (type){list}   |                   Compound literal(C99)                  |   Left-to-right  |
|                  |                  |                                                          |                  |
|         2        |       ++ --      |              Prefix increment and decrement              |   Right-to-left  |
|         2        |        + -       |                   Unary plus and minus                   |   Right-to-left  |
|         2        |        ! ~       |                Logical NOT and bitwise NOT               |   Right-to-left  |
|         2        |      (type)      |                           Cast                           |   Right-to-left  |
|         2        |         *        |                 Indirection (dereference)                |   Right-to-left  |
|         2        |         &        |                        Address-of                        |   Right-to-left  |
|         2        |      sizeof      |                          Size-of                         |   Right-to-left  |
|         2        |     _Alignof     |                Alignment requirement(C11)                |   Right-to-left  |
|                  |                  |                                                          |                  |
|         3        |       * / %      |          Multiplication, division, and remainder         |   Left-to-right  |
|         4        |        + -       |                 Addition and subtraction                 |   Left-to-right  |
|         5        |       << >>      |            Bitwise left shift and right shift            |   Left-to-right  |
|                  |                  |                                                          |                  |
|         6        |       < <=       |       For relational operators < and ≤ respectively      |   Left-to-right  |
|         6        |       > >=       |       For relational operators > and ≥ respectively      |   Left-to-right  |
|                  |                  |                                                          |                  |
|         7        |       == !=      |            For relational = and ≠ respectively           |   Left-to-right  |
|         8        |         &        |                        Bitwise AND                       |   Left-to-right  |
|         9        |         ^        |                Bitwise XOR (exclusive or)                |   Left-to-right  |
|        10        |        \|        |                 Bitwise OR (inclusive or)                |   Left-to-right  |
|        11        |        &&        |                        Logical AND                       |   Left-to-right  |
|        12        |       \|\|       |                        Logical OR                        |   Left-to-right  |
|                  |                  |                                                          |                  |
|        13        |        ?:        |                    Ternary conditional                   |   Right-to-left  |
|        14        |         =        |                     Simple assignment                    |   Right-to-left  |
|        14        |       += -=      |             Assignment by sum and difference             |   Right-to-left  |
|        14        |     *= /= %=     |      Assignment by product, quotient, and remainder      |   Right-to-left  |
|        14        |      <<= >>=     |     Assignment by bitwise left shift and right shift     |   Right-to-left  |
|        14        |     &= ^= \|=    |          Assignment by bitwise AND, XOR, and OR          |   Right-to-left  |
|                  |                  |                                                          |                  |
|        15        |         ,        |                           Comma                          |   Left-to-right  |