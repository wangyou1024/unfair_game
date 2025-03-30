import QtQuick 2.5

Item{
    width: 800; height: 500
    Rectangle {
        id: root
        width: viewModel.contentWidth
        height: viewModel.contentHeight
        anchors.centerIn: parent
        color: "black"  // 设置背景颜色为黑色
        Row{
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            spacing: 0
            Column {
                spacing: 10
                Text{
                    text: "李显圣获得"
                    horizontalAlignment: Text.AlignRight-60
                    verticalAlignment: Text.AlignVCenter
                    color: "white"  // 设置字体颜色为白色
                    font.pixelSize: 30  // 设置字体大小
                    x: -57
                }
                Text{
                    text: "你获得"
                    horizontalAlignment: Text.AlignRight
                    verticalAlignment: Text.AlignVCenter
                    color: "white"  // 设置字体颜色为白色
                    font.pixelSize: 30  // 设置字体大小
                }

            }
            Column {
                spacing: 10
                Text{
                    text: viewModel.randomValue != 0?(10-viewModel.randomValue)+"元":"0元"
                    horizontalAlignment: Text.AlignLeft
                    verticalAlignment: Text.AlignVCenter
                    color: "white"  // 设置字体颜色为白色
                    font.pixelSize: 30  // 设置字体大小
                }
                Text{
                    text: viewModel.randomValue != 0?viewModel.randomValue+"元":"0元"
                    horizontalAlignment: Text.AlignLeft
                    verticalAlignment: Text.AlignVCenter
                    color: "white"  // 设置字体颜色为白色
                    font.pixelSize: 30  // 设置字体大小
                }
            }
        }

    }
}
