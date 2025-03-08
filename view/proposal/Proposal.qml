import QtQuick 2.5

Item{
    width: 800; height: 500
    Rectangle {
        id: root
        width: viewModel.contentWidth-100
        height: viewModel.contentHeight
        anchors.centerIn: parent
        anchors.margins: 50

        Rectangle {
            id: matcherProposalRec
            anchors.left: parent.left
            width: parent.width*0.7
            height: 50
            anchors.verticalCenter: parent.verticalCenter
            color: "red"
        }

        Text {
            id: matcherName
            text: "李显圣"
            horizontalAlignment: Text.AlignLeft
            anchors.left: matcherProposalRec.left
            anchors.bottom: matcherProposalRec.top
        }
        Text {
            id: matcherProposalText
            text: "7"
            horizontalAlignment: Text.AlignLeft
            anchors.left: matcherProposalRec.left
            anchors.top: matcherProposalRec.bottom
        }


        Rectangle {
            id: yourProposalRec
            anchors.right: parent.right
            width: parent.width*0.3
            height: 50
            anchors.verticalCenter: parent.verticalCenter
            color: "green"
        }

        Text {
            id: yourName
            text: "你"
            horizontalAlignment: Text.AlignLeft
            anchors.right: yourProposalRec.right
            anchors.bottom: yourProposalRec.top
        }
        Text {
            id: yourProposalText
            text: "7"
            horizontalAlignment: Text.AlignLeft
            anchors.right: yourProposalRec.right
            anchors.top: yourProposalRec.bottom
        }

        MouseArea {
            id: buttonMouseArea
            objectName: "buttonMouseArea"
            anchors.fill: parent
            onClicked: {
                viewModel.openResult()
            }
        }

        focus: true
        Keys.enabled: true
        Keys.onPressed: {
            if (event.key == Qt.Key_F && viewModel.currentPage == "proposal"){
                viewModel.agreeProposal()
            }else if(viewModel.currentPage == "proposal"){
                viewModel.disagreeProposal()
            }
        }
    }
}
