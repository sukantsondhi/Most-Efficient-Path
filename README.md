# Most-Efficient-Path

## Implementing uninformed search strategies in Prolog to find paths in a house layout

Finding paths between locations, searching bi-directionally from two origins to a common destination, and incorporating costs to find the cheapest paths. The code handles various scenarios, avoids loops, and provides meaningful error messages.

### Rooms and Cost Layout

![alt text](./Resources/Ground%20Layout.png)

![alt text](./Resources/Cost%20Layout.png)

## If you would like to read about the Search Strategies, please refer to the [Search Strategies](./Search%20Stratergies.md) file.

# Tasks

## 3.1
Define the rooms and their connections in the graph.
The `room/2` predicate defines the direct connections between rooms.
The `connected/2` predicate checks if two rooms are directly connected.
The `room/3` predicate defines the connections between rooms along with their corresponding weights.

## 3.2
The `bdSearch/4` predicate finds the most efficient path between two given locations via a third location.
It uses the `travel/4` predicate to find the paths from the origin to the third location and from the third location to the destination.
The `deleteLast/2` predicate deletes the last element from a list.

## 3.3
The `find/5` predicate finds the most efficient path between two given locations and calculates its length.
It uses the `travel/5` predicate to recursively traverse the graph and calculate the length of the path.
The `shortest/4` predicate finds the shortest path between two given locations.
The `minimal/3` predicate finds the path with the minimum length from a set of paths.
The `bdSearchShortest/5` predicate finds the shortest path between two given locations via a third location.

The code allows you to find the most efficient path between two locations in a graph of interconnected rooms.

The code provides several predicates to perform different tasks:

- `find/4` finds the most efficient path between two locations.
- `bdSearch/4` finds the most efficient path between two locations via a third location.
- `find/5` finds the most efficient path between two locations and calculates its length.
- `bdSearchShortest/5` finds the shortest path between two locations via a third location.
The code also includes helper predicates to handle graph connections and path calculations.
To use this code, you need to define the rooms and their connections in the graph using the `room/2` and `room/3` predicates.
Then, you can call the desired predicates to find the most efficient or shortest path between locations.


