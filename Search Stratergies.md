# Overview

The `Main.pl` file implements various uninformed search strategies in Prolog to navigate a house layout. The primary tasks include:

1. Finding paths between locations.
2. Searching bi-directionally from two origins to a common destination.
3. Incorporating costs to find the cheapest paths.

### Rooms and Connections

The house layout is defined using `room/2` and `room/3` predicates:

- `room/2`: Defines direct connections between rooms.
- `room/3`: Defines connections between rooms with associated costs.

![alt text](./Resources/Ground%20Layout.png)

![alt text](./Resources/Cost%20Layout.png)

# Search Strategies

## Finding Paths

The `find/3` predicate finds a path between two locations:

```prolog
find(O, D, List) :-
    tSame(O, D), !, fail;
    travel(O, D, [O], List) ->
        printIt(List); write('Either the Origin or the Destination does not Exist.').
```

## Bi-Directional Search

The `bdSearch/4` predicate performs a bi-directional search from two origins to a common destination:

```prolog
bdSearch(O1, O2, D, _Path) :-
    travel(O1, D, [O1], O1toD) ->
        travel(D, O2, [D], DtoO2) ->
            deleteLast(DtoO2, DtoO2_Cut),
            append(DtoO2_Cut, O1toD, Path),
            printIt(Path).
```

## Finding Shortest Path

The `shortest/4` predicate finds the shortest path between two locations:

```prolog
shortest(A, B, Path, Length) :-
    setof([P, L], find(A, B, P, L), Set),
    Set = [_|_],
    minimal(Set, [Path, Length]).
```

The `bdSearchShortest/5` predicate performs a bi-directional search to find the shortest path:

```prolog
bdSearchShortest(O1, O2, D, Path, Length) :-
    shortest(O1, D, O1toD, O1toD_L),
    shortest(D, O2, DtoO2, DtoO2_L),
    deleteLast(DtoO2, DtoO2_Cut),
    Length is O1toD_L + DtoO2_L,
    append(DtoO2_Cut, O1toD, Path),
    printIt(Path).
```

## Utility Predicates

- `connected/2` and `connected/3`: Check if two rooms are connected.
- `travel/4` and `travel/5`: Traverse from one room to another.
- `printIt/1`: Print the path.
- `deleteLast/2`: Delete the last element from a list.
- `tSame/2`: Check if two locations are the same.
- `minimal/2` and `min/3`: Find the minimal path.

## Example Usage

To find a path from outside to livingRoom:

```prolog
?- find(outside, livingRoom, Path).
```

To perform a bi-directional search from outside and porch2 to livingRoom:

```prolog
?- bdSearch(outside, porch2, livingRoom, Path).
```

To find the shortest path from outside to livingRoom:

```prolog
?- shortest(outside, livingRoom, Path, Length).
```

To perform a bi-directional search for the shortest path:

```prolog
?- bdSearchShortest(outside, porch2, livingRoom, Path, Length).
```

