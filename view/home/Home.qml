import QtQuick 2.5
import QtQuick.Particles 2.0

Item{
    width: 800; height: 500
    property int fontSize: 15
    property string red: "#FF5A33"
    property string yellow: "#FFEC5C"
    property string yellow_green: "#B4CF66"
    property string green: "#44803F"
    property string green_black: "#146152"

    Rectangle {
        id: root
        width: viewModel.contentWidth
        height: viewModel.contentHeight
        anchors.centerIn: parent
        color: "#222222"

        Text {
            id: moneyTitle
            text: "MONEY"
            width: parent.width/7
            color: "white"
            font.pixelSize: fontSize
            anchors.top: parent.top
            anchors.left:parent.left
            anchors.leftMargin: parent.width/5
            anchors.topMargin: 50
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }

        Rectangle{
            id: accountRec
            width: moneyTitle.width
            height: 32
            color: parent.color
            border.width: 2
            radius: height/2
            border.color: yellow
            anchors.top: moneyTitle.bottom
            anchors.left:moneyTitle.left

            Text{
                id: moneyText
                text: "¥"+viewModel.wealth
                color: "white"
                font.pixelSize: 15
                anchors.centerIn: parent
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }
            
            // 在组件加载完成时启动动画
            Component.onCompleted: {
                colorAnimation.start()
            }

            // 动态颜色变化动画
            SequentialAnimation {
                id: colorAnimation
                loops: Animation.Infinite
                ColorAnimation {
                    target: accountRec
                    property: "border.color"
                    from: yellow_green
                    to: yellow
                    duration: 3000
                    easing.type: Easing.InOutQuint;
                }
                ColorAnimation {
                    target: accountRec
                    property: "border.color"
                    from: yellow
                    to: yellow_green
                    duration: 3000
                    easing.type: Easing.InOutQuint;
                }
            }

        }

        Text {
            id: rankTitle
            text: "RANK"
            width: moneyTitle.width
            color: "white"
            font.pixelSize: fontSize
            anchors.top: moneyTitle.top
            anchors.right:parent.right
            anchors.rightMargin: moneyTitle.anchors.leftMargin
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }

       
        Rectangle{
            id: rankRec
            width: accountRec.width
            height: accountRec.height
            color: parent.color
            border.width: accountRec.border.width
            radius: height/2
            border.color: accountRec.border.color
            anchors.top: rankTitle.bottom
            anchors.left:rankTitle.left

            Text{
                text: viewModel.rank+"/150"
                color: "white"
                font.pixelSize: 15
                anchors.centerIn: parent
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }
        }

        
        Rectangle{
            id: goldCoin
            width: parent.width/4
            height: width
            anchors.centerIn: parent
            color: parent.color
            // 粒子系统
            ParticleSystem {
                id: particleSystem
            }

            // 粒子画笔
            ItemParticle  {
                id: itemParticle
                system: particleSystem
                // 粒子组
                groups: "实例化"
                // 粒子视图
                delegate: Rectangle {
                    width: itemParticle.parent.width > itemParticle.parent.height?
                               itemParticle.parent.height * 0.02:
                               itemParticle.parent.width * 0.02
                    height: width
                    radius: height / 2
                    border.width: radius * 0.8
                    border.color: accountRec.border.color
                    
                }
                // 是否在生命周期结束时自动淡出
                fade: true
            }

            // 发射器
            Emitter {
                id: emitter
                anchors.fill: parent
                system: particleSystem
                // 发射器的形状
                shape: MaskShape {
                    // 该图像不透明度非0的区域被视为形状内部
                    source: "gold_coin1.png"
                }
                // 粒子起始加速度
                acceleration: PointDirection {
                    // x y 是指方向上的分量
                    // xVariation yVariation 是指分量上的误差范围
                    x: 0
                    y: 0
                    xVariation: 0;
                    yVariation: 0;
                }
                // 每秒发射多少粒子
                emitRate: 15000
                // 粒子最大发射量
                maximumEmitted: 4000
                // 粒子群
                group: "实例化"
                // 粒子生命周期(毫秒)
                lifeSpan: 200
                // 生命周期误差区间(毫秒)
                lifeSpanVariation: 0
                // 粒子发射方向
                velocity: CumulativeDirection {
                    AngleDirection {
                        angleVariation: 360
                        magnitudeVariation: 80
                    }
                    PointDirection {
                        y: 20
                    }
                }
                // 使能
                enabled: true
            }

            // 影响器
            Age{
                id: affection
                width: parent.width/5
                height: parent.width/5
                shape:EllipseShape{
                    fill: true
                }
                system:particleSystem
                // 进入影响器范围时立即消失
                lifeLeft: 0
                once: true
            }
        }

        Rectangle{
            id: matchRec
            width: goldCoin.width
            height: 50
            color: parent.color
            border.width: accountRec.border.width
            radius: 10
            border.color: accountRec.border.color
            anchors.top: goldCoin.bottom
            anchors.left:goldCoin.left
            anchors.topMargin: 50
            Text{
                text: "对战"
                color: "white"
                font.pixelSize: 30
                font.bold: true
                font.weight: Font.Bold
                anchors.centerIn: parent
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }
        }

        MouseArea {
            id: buttonMouseArea
            objectName: "buttonMouseArea"
            anchors.fill: parent
            onClicked: {
                if (mouseX >= matchRec.x && mouseX <= matchRec.x+matchRec.width 
                    && mouseY >= matchRec.y && mouseY <= matchRec.y+matchRec.height ){
                    viewModel.openMatch()
                }
                    
            }
            hoverEnabled: true
            onPositionChanged: {
                affection.x = mouseX-goldCoin.x-affection.width*0.5
                affection.y = mouseY-goldCoin.y-affection.height*0.5
            }
        }

    }
}
