import QtQuick 2.5

Item{
    width: 800; height: 500
    Rectangle {
        id: root
        width: viewModel.contentWidth
        height: viewModel.contentHeight
        anchors.centerIn: parent
        color: "black"  // 设置背景颜色为黑色
        Rectangle{
            id: matchRec
            width: parent.width/5
            height: 50
            color: parent.color
            border.width: 2
            radius: height/2
            border.color: "#B4CF66"
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.topMargin: 40

            Text{
                id: moneyText
                text: "正在匹配"
                color: "white"
                font.pixelSize: 25
                anchors.centerIn: parent
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }
        }

        Image{
            id: processImage
            width: parent.width/4
            height: width
            source: "process.png"
            anchors.centerIn: parent
        }

         // 在组件加载完成时启动动画
        // Component.onCompleted: {
        //     imageAnimation.start()
        // }

        onVisibleChanged: {
            if (visible) {
                imageAnimation.start()  // 当 visible 变为 true 时启动动画
            }
        }


        // 动态颜色变化动画
        SequentialAnimation {
            id: imageAnimation
            loops: Animation.Infinite
            PropertyAnimation {
                target: processImage
                property: "rotation"
                from: 0
                to: 360
                duration: 2000
                easing.type: Easing.InOutQuint;
            }
        }
    }
}
