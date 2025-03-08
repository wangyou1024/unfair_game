from PyQt5.QtGui import QGuiApplication, QColor, QPen, QPainter
from PyQt5.QtQuick import QQuickView, QQuickPaintedItem
from PyQt5.QtQml import qmlRegisterType

import os
from pathlib import Path

import sys

from PyQt5.QtCore import pyqtProperty, QObject, QUrl, pyqtSignal, QRectF

class PieChart (QQuickPaintedItem):

    nameChanged = pyqtSignal()
    def __init__(self, parent=None):
        QQuickPaintedItem.__init__(self, parent)
        self._name = u''
        self._color = QColor()

    def boundingRect(self):
        # 定义饼图的边界矩形
        return QRectF(0, 0, 100, 100)

    def paint(self, painter):
        pen = QPen(self.color, 2)
        painter.setPen(pen)
        painter.setRenderHints(QPainter.RenderHint.Antialiasing, True)
        painter.drawPie(self.boundingRect().adjusted(1, 1, -1, -1), 90 * 16, 290 * 16)

    @pyqtProperty(QColor, final=True)
    def color(self):
        return self._color

    @color.setter
    def color(self, value):
        self._color = value

    @pyqtProperty(str, notify=nameChanged, final=True)
    def name(self):
        return self._name

    @name.setter
    def name(self, value):
        self._name = value

if __name__ == "__main__":
    app = QGuiApplication(sys.argv)
    qmlRegisterType(PieChart, "MyChart", 1, 0, "PieChart")
    view = QQuickView()
    view.setResizeMode(QQuickView.ResizeMode.SizeRootObjectToView)
    qml_file = os.fspath(Path(__file__).resolve().parent / 'App.qml')
    view.setSource(QUrl.fromLocalFile(qml_file))
    if view.status() == QQuickView.Status.Error:
        sys.exit(-1)
    view.show()
    res = app.exec()
    # Deleting the view before it goes out of scope is required to make sure all child QML instances
    # are destroyed in the correct order.
    del view
    sys.exit(res)