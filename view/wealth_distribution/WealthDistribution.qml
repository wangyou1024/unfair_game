import QtQuick 2.5
import QtQuick.Particles 2.0

Item {
    width: viewModel.contentWidth
    height: viewModel.contentHeight
    property int rootMargin: 30
    property int accountRecWidth: viewModel.contentWidth / 10
    property int accountSpace: 10
    property int allocateAccountNum: 10
    
    Rectangle {
        id: root
        width: viewModel.contentWidth
        height: viewModel.contentHeight
        anchors.centerIn: parent
        color: "black" // 添加这行设置背景颜色为黑色

        Row {

            anchors.fill: parent
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: rootMargin

            Rectangle {
                id: accountDiff
                width: viewModel.contentWidth / 2
                height: viewModel.contentHeight
                color: "black"
                Text {
                    id: matcherName
                    text: viewModel.matcherName
                    width: accountRecWidth
                    anchors.bottom: accountDiff.bottom
                    anchors.left: accountDiff.left
                    anchors.leftMargin: accountDiff.width-3*accountRecWidth-3*accountSpace-50
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font.pixelSize: 25
                    color: "white"
                }
                Rectangle {
                    id: matcherRec
                    width: accountRecWidth
                    height: viewModel.contentHeight - matcherName.height * 2
                    anchors.bottom: matcherName.top
                    anchors.left: matcherName.left
                    color: "red"
                }
                Text {
                    id: matcherAccount
                    text: viewModel.matcherWealth+"元"
                    width: accountRecWidth
                    anchors.bottom: matcherRec.top
                    anchors.left: matcherName.left
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font.pixelSize: 25
                    color: "white"
                }

                Text {
                    id: yourName
                    text: "你"
                    width: accountRecWidth
                    anchors.bottom: matcherName.bottom
                    anchors.left: matcherName.right
                    anchors.leftMargin: accountSpace
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font.pixelSize: 25
                    color: "white"
                }
                Rectangle {
                    id: yourRec
                    width: accountRecWidth
                    height: matcherRec.height * (viewModel.wealth / viewModel.matcherWealth)
                    anchors.bottom: yourName.top
                    anchors.left: yourName.left
                    color: "green"
                }
                Text {
                    id: yourAccount
                    text: viewModel.wealth+"元"
                    width: accountRecWidth
                    anchors.bottom: yourRec.top
                    anchors.left: yourName.left
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font.pixelSize: 25
                    color: "white"
                }

                Text {
                    id: allocateAccount
                    text: "10元"
                    width: accountRecWidth
                    anchors.top: accountDiff.top
                    anchors.left: yourName.right
                    anchors.leftMargin: accountSpace
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font.pixelSize: 25
                    color: "white"
                }

                Rectangle {
                    id: allocateAccountRec
                    width: accountRecWidth
                    height: matcherRec.height * (allocateAccountNum / viewModel.matcherWealth)
                    anchors.top: allocateAccount.bottom
                    anchors.left: allocateAccount.left
                    color: "gray"
                }

                Text {
                    id: waitAllocate
                    text: "待分配"
                    width: accountRecWidth
                    anchors.top: allocateAccountRec.bottom
                    anchors.left: allocateAccountRec.left
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font.pixelSize: 25
                    color: "white"
                }

                ParallelAnimation {
                    id: parallelAnimation
                    PropertyAnimation {
                        id: matcherAnimation
                        target: matcherRec
                        property: "height"
                        from: 1
                        to: matcherRec.height
                        duration: 1000
                        easing.type: Easing.InOutQuint;
                    }
                }
            }
            Rectangle {
                id: distribution
                width: viewModel.contentWidth / 2
                height: viewModel.contentHeight
                color: "black"
                DistributionItem {
                    id: accountPerson9
                    anchors.top: parent.top
                    anchors.leftMargin: 50
                    currentWealth: viewModel.wealth+180
                    person: viewModel.wealth180_199
                }
                DistributionItem {
                    id: accountPerson8
                    anchors.top: accountPerson9.bottom
                    anchors.left: accountPerson9.left
                    currentWealth: viewModel.wealth + 160
                    person: viewModel.wealth160_179
                }
                DistributionItem {
                    id: accountPerson7
                    anchors.top: accountPerson8.bottom
                    anchors.left: accountPerson9.left
                    currentWealth: viewModel.wealth + 140
                    person: viewModel.wealth140_159
                }
                DistributionItem {
                    id: accountPerson6
                    anchors.top: accountPerson7.bottom
                    anchors.left: accountPerson9.left
                    currentWealth: viewModel.wealth + 120
                    person: viewModel.wealth120_139
                }
                DistributionItem {
                    id: accountPerson5
                    anchors.top: accountPerson6.bottom
                    anchors.left: accountPerson9.left
                    currentWealth: viewModel.wealth + 100
                    person: viewModel.wealth100_119
                }
                DistributionItem {
                    id: accountPerson4
                    anchors.top: accountPerson5.bottom
                    anchors.left: accountPerson9.left
                    currentWealth: viewModel.wealth + 80
                    person: viewModel.wealth80_99
                }
                DistributionItem {
                    id: accountPerson3
                    anchors.top: accountPerson4.bottom
                    anchors.left: accountPerson9.left
                    currentWealth: viewModel.wealth + 60
                    person: viewModel.wealth60_79
                }
                DistributionItem {
                    id: accountPerson2
                    anchors.top: accountPerson3.bottom
                    anchors.left: accountPerson9.left
                    currentWealth: viewModel.wealth + 40
                    person: viewModel.wealth40_59
                }
                DistributionItem {
                    id: accountPerson1
                    anchors.top: accountPerson2.bottom
                    anchors.left: accountPerson9.left
                    currentWealth: viewModel.wealth + 20
                    person: viewModel.wealth20_39
                }
                DistributionItem {
                    id: accountPerson0
                    anchors.top: accountPerson1.bottom
                    anchors.left: accountPerson9.left
                    currentWealth: viewModel.wealth
                    person: viewModel.wealth0_19
                }
            }
        }
    }

    MouseArea {
        id: buttonMouseArea
        objectName: "buttonMouseArea"
        anchors.fill: parent
        onClicked: {
            viewModel.openWaitProposal()
        }
    }

    // 监听 visible 属性的变化
    onVisibleChanged: {
        if (visible) {
            parallelAnimation.start()  // 当 visible 变为 true 时启动动画
        }
    }
}
