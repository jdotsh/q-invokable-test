import QtQuick 2.11
import QtQuick.Window 2.11
import QtPositioning 5.11

Window {
    visible: true
    width: 20
    height: 20
    title: qsTr("Hello World")

    Component.onCompleted: {

        console.log("Executing")
        var coords = [ QtPositioning.coordinate( 10, -10), // main polygon
                       QtPositioning.coordinate( 10,  10),
                       QtPositioning.coordinate(-10,  10),
                       QtPositioning.coordinate(-10, -10),
                       QtPositioning.coordinate(10, -10)]        

        var hole0 = [ QtPositioning.coordinate(5, -5),
                     QtPositioning.coordinate( 5, 5),
                     QtPositioning.coordinate(-5, 5),
                     QtPositioning.coordinate(-5, -5),
                     QtPositioning.coordinate(5, -5)]

        var hole1 = [ QtPositioning.coordinate(6, -6),
                     QtPositioning.coordinate( 7, -6),
                     QtPositioning.coordinate(7, -7),
                     QtPositioning.coordinate(6, -7),
                     QtPositioning.coordinate(6, -6)]

        var hole2 = [ QtPositioning.coordinate(6, 6),
                     QtPositioning.coordinate(7, 6),
                     QtPositioning.coordinate(7, 7),
                     QtPositioning.coordinate(6, 7),
                     QtPositioning.coordinate(6, 6)]

        var poly = QtPositioning.polygon(coords)

        poly.addHole(hole0)
        poly.addHole(hole1)
        poly.addHole(hole2)
        // using the setter to store holes data

        console.log(poly.holesCount())
        // correctly returns:
        // "qml: 3"

        var firstHole = poly.hole(0)
        //using the getter to extract an hole

        console.log(firstHole)
        // correctly returns:
        // "qml: [6° 0' 0.0" N, 6° 0' 0.0" W,7° 0' 0.0" N, 6° 0' 0.0" W,7° 0' 0.0" N, 7° 0' 0.0" W,6° 0' 0.0" N, 7° 0' 0.0" W,6° 0' 0.0" N, 6° 0' 0.0" W]"

        console.log("Point in hole0, should return false: " + poly.contains(QtPositioning.coordinate(0,0)))
        console.log("Point on hole0 boundary, should return true: " + poly.contains(QtPositioning.coordinate(5,0)))
        console.log("Point in hole1, should return false: " + poly.contains(QtPositioning.coordinate(6.5,-6.5)))
        console.log("Point on hole1 boundary, should return true: " + poly.contains(QtPositioning.coordinate(6.5,-6)))
        console.log("Point in hole2, should return false: " + poly.contains(QtPositioning.coordinate(6.5,6.5)))
        console.log("Point on hole2 boundary, should return true: " + poly.contains(QtPositioning.coordinate(6.5,6)))
        // uncorrectly returns true.
        // it seems that contains method doesn't recognize holes loaded from QML
        // on the same polygon, the contains method works as expected in C++
        // now re-thinking the whole implementation

        console.log("Point outside polygon, should return false: " + poly.contains(QtPositioning.coordinate(20,20)))
        console.log("Point on polygon boundary, should return true: " + poly.contains(QtPositioning.coordinate(10,0)))
        console.log("Point in polygon, not in hole, should return true: " + poly.contains(QtPositioning.coordinate(8,8)))
    }
}

