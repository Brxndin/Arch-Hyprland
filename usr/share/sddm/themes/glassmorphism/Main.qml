import QtQuick
import QtQuick.Controls
import Qt5Compat.GraphicalEffects

Rectangle {
    id: root
    width: 1920
    height: 1080

    Image {
        id: bgImage
        anchors.fill: parent
        source: config.background
        fillMode: Image.PreserveAspectCrop
    }

    FastBlur {
        anchors.fill: parent
        source: bgImage
        radius: 32
        
        Rectangle {
            anchors.fill: parent
            color: Qt.rgba(30/255, 30/255, 46/255, 0.8) 
        }
    }

    Item {
        anchors.centerIn: parent
        anchors.verticalCenterOffset: -200

        Text {
            id: timeText
            anchors.horizontalCenter: parent.horizontalCenter
            text: new Date().toLocaleTimeString(Qt.locale(), Locale.ShortFormat)
            color: "white"
            font.family: config.font
            font.pixelSize: 80
            font.bold: true
        }

        Text {
            anchors.top: timeText.bottom
            anchors.topMargin: 5
            anchors.horizontalCenter: parent.horizontalCenter
            text: new Date().toLocaleDateString(Qt.locale(), "ddd, d 'de' MMMM")
            color: "white"
            font.family: config.font
            font.pixelSize: 22
        }
    }

    Text {
        anchors.centerIn: parent
        anchors.verticalCenterOffset: -10
        text: "Olá!"
        color: "white"
        font.family: config.font
        font.pixelSize: 18
    }

    Rectangle {
        id: userBox
        width: 350
        height: 48
        anchors.centerIn: parent
        anchors.verticalCenterOffset: 60
        
        color: Qt.rgba(51/255, 51/255, 51/255, 0.8) 
        
        border.color: "white"
        border.width: 2 
        radius: 0 
        
        TextInput {
            id: userInput
            anchors.fill: parent
            anchors.margins: 10
            verticalAlignment: TextInput.AlignVCenter
            horizontalAlignment: TextInput.AlignHCenter
            
            font.family: config.font
            font.pixelSize: 18
            color: "white"

            focus: true

            KeyNavigation.tab: passwordInput

            Text {
                text: "Usuário"
                color: "#aaa"
                visible: !parent.text && !parent.activeFocus
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
            }
        }
    }

    Rectangle {
        id: passwordBox
        width: 350
        height: 48
        anchors.centerIn: parent
        anchors.verticalCenterOffset: 120
        
        color: Qt.rgba(51/255, 51/255, 51/255, 0.8) 
        
        border.color: "white"
        border.width: 2 
        radius: 0 
        
        TextInput {
            id: passwordInput
            anchors.fill: parent
            anchors.margins: 10
            verticalAlignment: TextInput.AlignVCenter
            horizontalAlignment: TextInput.AlignHCenter
            
            font.family: config.font
            font.pixelSize: 18
            color: "white"
            
            echoMode: TextInput.Password
            passwordCharacter: "•"
            focus: true

            KeyNavigation.backtab: userInput

            Text {
                text: "Senha"
                color: "#aaa"
                visible: !parent.text && !parent.activeFocus
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
            }
            
            onAccepted: {
                sddm.login(userInput.text, passwordInput.text, sessionModel.lastIndex)
            }
        }
    }

    /*
    // botão de entrar
    // não é tão necessário, já funciona com o enter
    Rectangle {
        id: loginButton
        width: 350
        height: 48
        anchors.centerIn: parent
        anchors.verticalCenterOffset: 180
        
        color: loginMouseArea.containsMouse ? Qt.rgba(80/255, 80/255, 80/255, 0.8) : Qt.rgba(51/255, 51/255, 51/255, 0.8)
        
        border.color: "white"
        border.width: 2 
        radius: 0 

        Text {
            anchors.centerIn: parent
            text: "Entrar"
            color: "white"
            font.family: config.font
            font.pixelSize: 18
        }

        MouseArea {
            id: loginMouseArea
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
            onClicked: {
                sddm.login(userInput.text, passwordInput.text, sessionModel.lastIndex)
            }
        }
    }
    */

    Row {
        anchors.centerIn: parent
        anchors.verticalCenterOffset: 190
        spacing: 20

        Rectangle {
            width: 165
            height: 48
            color: rebootMouseArea.containsMouse ? Qt.rgba(80/255, 80/255, 80/255, 0.8) : Qt.rgba(51/255, 51/255, 51/255, 0.8)
            border.color: "white"
            border.width: 2
            radius: 0

            Text {
                anchors.centerIn: parent
                text: "Reiniciar"
                color: "white"
                font.family: config.font
                font.pixelSize: 16
            }

            MouseArea {
                id: rebootMouseArea
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onClicked: sddm.reboot()
            }
        }

        Rectangle {
            width: 165
            height: 48
            color: powerMouseArea.containsMouse ? Qt.rgba(80/255, 80/255, 80/255, 0.8) : Qt.rgba(51/255, 51/255, 51/255, 0.8)
            border.color: "white"
            border.width: 2
            radius: 0

            Text {
                anchors.centerIn: parent
                text: "Desligar"
                color: "white"
                font.family: config.font
                font.pixelSize: 16
            }

            MouseArea {
                id: powerMouseArea
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onClicked: sddm.powerOff()
            }
        }
    }
}
