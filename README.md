# q_invokable_test
This app is meant to test if the Hole implementation in QGeoPolygon C++ class is correctly usable from QML.

#### History
July 9, 2018: not yet working, holes defined in QML are not correctly recognized by contains methos
July 10,2018: Workig. Requires patchset7. Fixing QML compatibility requered a much more simple approach di data type definition in holes implementation
