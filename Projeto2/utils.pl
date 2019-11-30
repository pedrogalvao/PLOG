exampleBoard(
    [
        [empty, 1, 0, empty, empty, empty],
        [empty, 6, empty, 3, 4],
        [
            [    3,  black,      2,      1,  black],
            [black,      1,  black,      2,      3],
            [    2,      3,  black,  black,      1],
            [black,      2,      1,      3,  black],
            [    1,  black,      3,  black,      2]
        ]
    ]
).

/* Board with wrong sums */
wrongBoard(
    [
        [empty, 1, 0, empty, empty, empty],
        [empty, 6, empty, 3, 4],
        [
            [    3,  black,      2,      1,  black],
            [black,      1,  black,      3,      3],
            [    2,      3,  black,  black,      1],
            [black,      2,      1,      2,  black],
            [    1,  black,      3,  black,      2]
        ]
    ]
).
