import QtQuick 2.5
Rectangle {
    property int currentWealth: 100
    property int person: 3
    property int distributionHeight: viewModel.contentHeight/10-5
    height: distributionHeight
    anchors.margins: 5
    Row {
        anchors.fill: parent
        spacing: 0
        Text {
            height: distributionHeight
            text: currentWealth +"元"
            horizontalAlignment: Text.AlignRight
            verticalAlignment: Text.AlignVCenter

        }
        Repeater {
            model: person  // 使用 PyQt 提供的数量
            delegate: Image {
                height: distributionHeight
                fillMode: Image.PreserveAspectFit
                source: "person.png"  // 固定图片路径
            }
        }
        Text {
            height: distributionHeight
            text: person +"人"
            horizontalAlignment: Text.AlignRight
            verticalAlignment: Text.AlignVCenter
        }
    }
}
