import QtQuick 2.6
import QtQuick.Window 2.2
import QtQuick.Controls 2.5   // это версия библиотеки, содержащей Contol (аналоги виджетов) для версии Qt 5.6
import QtQuick.Layouts 1.2


Window {
    id: root
    modality: Qt.ApplicationModal  // окно объявляется модальным
    title: qsTr("Информация о собаке")
    minimumWidth: 400
    maximumWidth: 400
    minimumHeight: 350
    maximumHeight: 350

    property bool isEdit: false
    property int currentIndex: -1

    GridLayout {
        anchors { left: parent.left; top: parent.top; right: parent.right; bottom: buttonCancel.top; margins: 10 }
        columns: 2

        Label {
            Layout.alignment: Qt.AlignRight  // выравнивание по правой стороне
            text: qsTr("Имя собаки:")
        }
        TextField {
            id: textName
            Layout.fillWidth: true
            placeholderText: qsTr("Введите имя собаки")
        }
        Label {
            Layout.alignment: Qt.AlignRight
            text: qsTr("Возраст собаки:")
        }
        SpinBox {
            id: textAge
            Layout.fillWidth: true
            value: 0
        }
        Label {
            Layout.alignment: Qt.AlignRight
            text: qsTr("Порода собаки:")
        }
        ComboBox
        {
            id: textBreed
            Layout.fillWidth: true
            model: ["Английский бульдог", "Пудель", "Золотистый ретривер", "Чихуахуа", "Мопс"]
        }
        Label {
            Layout.alignment: Qt.AlignRight
            text: qsTr("Владелец собаки:")
        }
        TextField {
            id: textOwner
            Layout.fillWidth: true
            placeholderText: qsTr("Введите владельца собаки")
        }
    }

    Button {
        anchors { right: buttonCancel.left; verticalCenter: buttonCancel.verticalCenter; rightMargin: 10 }
        text: qsTr("ОК")
        width: 100
        onClicked: {
            root.hide()
            if (currentIndex<0)
            {
                add(textName.text, textAge.value, textBreed.currentValue, textOwner.text)
            }
            else
            {
                edit(textName.text, textAge.value, textBreed.currentValue, textOwner.text, root.currentIndex)
            }

        }
    }

    Button {
        id: buttonCancel
        anchors { right: parent.right; bottom: parent.bottom; rightMargin: 10; bottomMargin: 10 }
        text: qsTr("Отменить")
        width: 100
        onClicked: {
             root.hide()
        }
    }

    // изменение статуса видимости окна диалога
    //!!!!
    onVisibleChanged: {
      if (visible && currentIndex < 0) {
          textName.text = ""
          textAge.value = 0
          textBreed.text = ""
          textOwner.text = ""
      }
    }

    function execute(nameDog, ageDog, breedDog, ownerDog, index){
        isEdit = true

        textName.text = nameDog
        textAge.value = ageDog
        textBreed.currentIndex = textBreed.model.indexOf(breedDog)
        textOwner.text = ownerDog

        root.currentIndex = index

        root.show()
    }


 }

