import QtQuick 2.6
import QtQuick.Controls 2.5  // это версия библиотеки, содержащей Contol (аналоги виджетов) для версии Qt 5.6
import QtQuick.Layouts 1.2

Rectangle {
    id: dogItem
    readonly property color evenBackgroundColor: "#f9f9f9"  // цвет для четных пунктов списка
    readonly property color oddBackgroundColor: "#ffffff"   // цвет для нечетных пунктов списка
    readonly property color selectedBackgroundColor: "#eaf1f7"  // цвет выделенного элемента списка

    property bool isCurrent: dogItem.ListView.view.currentIndex === index   // назначено свойство isCurrent истинно для текущего (выделенного) элемента списка
    property bool selected: dogItemMouseArea.containsMouse || isCurrent // назначено свойство "быть выделенным",
    //которому присвоено значение "при наведении мыши,
    //или совпадении текущего индекса модели"

    property variant dogData: model // свойство для доступа к данным конкретного студента

    width: parent ? parent.width : dogList.width
    height: 150

    // состояние текущего элемента (Rectangle)
    states: [
        State {
            when: selected
            // как реагировать, если состояние стало selected
            PropertyChanges { target: dogItem;  // для какого элемента должно назначаться свойство при этом состоянии (selected)
                color: isCurrent ? palette.highlight : selectedBackgroundColor  /* какое свойство целевого объекта (Rectangle)
                                                                                                  и какое значение присвоить*/
            }
        },
        State {
            when: !selected
            PropertyChanges { target: dogItem;  color: isCurrent ? palette.highlight : index % 2 == 0 ? evenBackgroundColor : oddBackgroundColor }
        }
    ]

    MouseArea {
        id: dogItemMouseArea
        anchors.fill: parent
        hoverEnabled: true
        onClicked: {
            dogItem.ListView.view.currentIndex = index
            dogItem.forceActiveFocus()
        }
    }
    Item {
        id: itemOfDogs
        width: parent.width
        height: 150
        Column{
            id: t2
            anchors.left: parent.left
            anchors.leftMargin: 10
            width: 240
            anchors.verticalCenter: parent.verticalCenter
            Text {
                id: t1
                anchors.horizontalCenter: parent.horizontalCenter
                text: "Имя собаки:"
                color: "firebrick"
                font.pointSize: 12
            }
            Text {
                id: textName
                anchors.horizontalCenter: parent.horizontalCenter
                text: DogName
                color: "red"
                font.pointSize: 18
                font.bold: true
            }
        }

        Column{
            anchors.left: t2.right
            anchors.leftMargin: 10
            anchors.verticalCenter: parent.verticalCenter
            Text {
                text: "Возраст"
                color: "firebrick"
                font.pointSize: 8
            }
            Text {
                id: textAge
                text: DogAge
                color: "purple"
                font.pointSize: 8
            }
            Text {
                text: "Порода"
                color: "firebrick"
                font.pointSize: 8
            }
            Text {
                id: textBreed
                color: "purple"
                text: DogBreed
                font.pointSize: 8
            }
            Text {
                text: "Владелец"
                color: "firebrick"
                font.pointSize: 8
            }
            Text {
                id: textOwner
                color: "purple"
                text: DogOwner
                font.pointSize: 8
            }
        }

    }
}
