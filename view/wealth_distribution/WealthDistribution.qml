import QtQuick 2.5
import QtQuick.Particles 2.0

Item{
    width: viewModel.contentWidth
    height: viewModel.contentHeight
    property int rootMargin: 30

    property int accountRecWidth: viewModel.contentWidth/10
    property int accountSpace: 10
    property int matcherAccountNum: 234
    property int yourAccountNum: 100
    property int allocateAccountNum: 10

    Rectangle {
        id: root
        width: viewModel.contentWidth
        height: viewModel.contentHeight
        anchors.centerIn: parent
        Row {
            anchors.fill: parent
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: rootMargin
            Rectangle {
                id: accountDiff
                width: viewModel.contentWidth/2
                height: viewModel.contentHeight
                Text {
                    id: matcherName
                    text: "李显圣"
                    width: accountRecWidth
                    anchors.bottom: accountDiff.bottom
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
                Rectangle{
                    id: matcherRec
                    width: accountRecWidth
                    height: viewModel.contentHeight-matcherName.height*2
                    anchors.bottom: matcherName.top
                    color: "red"
                }
                Text {
                    id: matcherAccount
                    text: matcherAccountNum
                    width: accountRecWidth
                    anchors.bottom: matcherRec.top
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
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
                }
                Rectangle{
                    id: yourRec
                    width: accountRecWidth
                    height: matcherRec.height*(yourAccountNum/matcherAccountNum)
                    anchors.bottom: yourName.top
                    anchors.left: yourName.left
                    color: "green"
                }
                Text {
                    id: yourAccount
                    text: yourAccountNum
                    width: accountRecWidth
                    anchors.bottom: yourRec.top
                    anchors.left: yourName.left
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }

                Text {
                    id: allocateAccount
                    text: "10"
                    width: accountRecWidth
                    anchors.top: accountDiff.top
                    anchors.left: yourName.right
                    anchors.leftMargin: accountSpace
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }

                Rectangle {
                    id: allocateAccountRec
                    width: accountRecWidth
                    height: matcherRec.height*(allocateAccountNum/matcherAccountNum)
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
                    }
                    PropertyAnimation {
                        id: yourAnimation
                        target: yourRec
                        property: "height"
                        from: 1
                        to: yourRec.height
                        duration: 1000
                    }
                }
            }
            Rectangle {
                id: distribution
                width: viewModel.contentWidth/2
                height: viewModel.contentHeight
                DistributionItem{
                    id: accountPerson9
                    anchors.top: parent.top
                    currentWealth: yourAccountNum+9
                    person: 3
                }
                DistributionItem{
                    id: accountPerson8
                    anchors.top: accountPerson9.bottom
                    currentWealth: yourAccountNum+8
                    person: 3
                }
                DistributionItem{
                    id: accountPerson7
                    anchors.top: accountPerson8.bottom
                    currentWealth: yourAccountNum+7
                    person: 3
                }
                DistributionItem{
                    id: accountPerson6
                    anchors.top: accountPerson7.bottom
                    currentWealth: yourAccountNum+6
                    person: 3
                }
                DistributionItem{
                    id: accountPerson5
                    anchors.top: accountPerson6.bottom
                    currentWealth: yourAccountNum+5
                    person: 3
                }
                DistributionItem{
                    id: accountPerson4
                    anchors.top: accountPerson5.bottom
                    currentWealth: yourAccountNum+4
                    person: 3
                }
                DistributionItem{
                    id: accountPerson3
                    anchors.top: accountPerson4.bottom
                    currentWealth: yourAccountNum+3
                    person: 3
                }
                DistributionItem{
                    id: accountPerson2
                    anchors.top: accountPerson3.bottom
                    currentWealth: yourAccountNum+2
                    person: 3
                }
                DistributionItem{
                    id: accountPerson1
                    anchors.top: accountPerson2.bottom
                    currentWealth: yourAccountNum+1
                    person: 3
                }
                DistributionItem{
                    id: accountPerson0
                    anchors.top: accountPerson1.bottom
                    currentWealth: yourAccountNum+0
                    person: 3
                }
            }
        }
    }

    MouseArea {
        id: buttonMouseArea
        objectName: "buttonMouseArea"
        anchors.fill: parent
        onClicked: {
             viewModel.openProposal()
        }
    }

    // 监听 visible 属性的变化
    onVisibleChanged: {
        if (visible) {
            parallelAnimation.start()  // 当 visible 变为 true 时启动动画
        }
    }

}
