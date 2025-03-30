import QtQuick 2.5

Item{
    width: 800; height: 500
    Rectangle {
        id: root
        width: viewModel.contentWidth
        height: viewModel.contentHeight
        anchors.centerIn: parent
        color:"black"
        Rectangle {
            id: matcherProposalRec
            width: (parent.width-200)*0.7
            height: 50
            anchors.verticalCenter: parent.verticalCenter
            color: "red"
            anchors.left: parent.left // 锚定到父元素左侧
            anchors.leftMargin: 100   // 左侧留出 100像素间距
        }

        Text {
            id: matcherName
            text: "李显圣"
            horizontalAlignment: Text.AlignLeft
            anchors.left: matcherProposalRec.left
            anchors.bottom: matcherProposalRec.top
            font.pixelSize: 25
            color: "white"
        }
        Text {
            id: matcherProposalText
            text: 10-viewModel.randomValue
            horizontalAlignment: Text.AlignLeft
            anchors.left: matcherProposalRec.left
            anchors.top: matcherProposalRec.bottom
            font.pixelSize: 25
            color: "white"
        }


        Rectangle {
            id: yourProposalRec
            anchors.right: parent.right
            anchors.rightMargin: 100
            width: (parent.width-200)*0.3
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
            font.pixelSize: 25
            color: "white"
        }
        Text {
            id: yourProposalText
            text: viewModel.randomValue
            horizontalAlignment: Text.AlignLeft
            anchors.right: yourProposalRec.right
            anchors.top: yourProposalRec.bottom
            font.pixelSize: 25
            color: "white"
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
