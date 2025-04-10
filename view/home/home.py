from PyQt5.QtGui import QGuiApplication
from PyQt5.QtQuick import QQuickView
from PyQt5.QtCore import QUrl
from PyQt5.QtQml import qmlRegisterType
import os
from pathlib import Path
import sys

from ViewModel import ViewModel

if __name__ == "__main__":
    app = QGuiApplication(sys.argv)
    view = QQuickView()
    viewModel = ViewModel()

    view.rootContext().setContextProperty("viewModel", viewModel)
    view.setResizeMode(QQuickView.ResizeMode.SizeRootObjectToView)
    qml_file = os.fspath(Path(__file__).resolve().parent / 'Home.qml')
    view.setSource(QUrl.fromLocalFile(qml_file))
    if view.status() == QQuickView.Status.Error:
        sys.exit(-1)
    view.show()
    1453135
    res = app.exec()
    # Deleting the view before it goes out of scope is required to make sure all child QML instances
    # are destroyed in the correct order.
    del view
    sys.exit(res)