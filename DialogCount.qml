import QtQuick 6.0
import QtQuick.Window 6.0
import QtQuick.Controls 6.0
import QtQuick.Layouts 6.0

// Окно ответа на условие о размере бассейна
Window {
    id: root
    // Говорим, что это окно является модальным
    modality: Qt.ApplicationModal
    title: qsTr("Ответ")
    width: 220
    height: 50

    GridLayout {
        anchors { left: parent.left;
                  top: parent.top;
                  right: parent.right;
                  margins: 10 }
        columns: 2

        Label {
            Layout.alignment: Qt.AlignRight
            text: qsTr("Получившийся результат:")
        }
        Label {
            id: textCount
            Layout.fillWidth: true
            text: "0"
        }

    }

    // Задаём функция для вывода информации
    function countDogs(breed){
        textCount.text = count(breed);
        root.show()
    }
 }
