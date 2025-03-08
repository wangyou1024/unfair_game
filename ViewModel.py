from PyQt5.QtCore import QObject, pyqtProperty, pyqtSignal, pyqtSlot, QTimer


class ViewModel(QObject):
    HOME_PAGE = "home"
    MATCH_PAGE = "match"
    WEALTH_DISTRIBUTION_PAGE = "wealth_distribution"
    WAIT_PROPOSAL_PAGE = "wait_proposal"
    PROPOSAL_PAGE = "proposal"
    RESULT_PAGE = "result"

    def __init__(self):
        super().__init__()
        self._content_width = 800
        self._content_height = 500
        self._name = "王游"
        self._wealth = 100
        self._rank = 1000
        self._current_page = self.HOME_PAGE


    contentWidthChanged = pyqtSignal(int)
    contentHeightChanged = pyqtSignal(int)
    nameChanged = pyqtSignal(str)
    wealthChanged = pyqtSignal(int)
    rankChanged = pyqtSignal(int)
    currentPageChanged = pyqtSignal(str)

    @pyqtSlot()
    def openHome(self):
        self.currentPage = self.HOME_PAGE

    @pyqtSlot()
    def openMatch(self):
        self.currentPage = self.MATCH_PAGE
        QTimer.singleShot(3000, self.openWealthDistribution)  # 3 秒后触发

    @pyqtSlot()
    def openWealthDistribution(self):
        self.currentPage = self.WEALTH_DISTRIBUTION_PAGE

    @pyqtSlot()
    def openWaitProposal(self):
        self.currentPage = self.WAIT_PROPOSAL_PAGE

    @pyqtSlot()
    def openProposal(self):
        self.currentPage = self.PROPOSAL_PAGE

    @pyqtSlot()
    def openResult(self):
        self.currentPage = self.RESULT_PAGE

    @pyqtSlot()
    def agreeProposal(self):
        print("同意")
        self.currentPage = self.RESULT_PAGE

    @pyqtSlot()
    def disagreeProposal(self):
        print("不同意")
        self.currentPage = self.RESULT_PAGE

    @pyqtProperty(int, notify=rankChanged)
    def rank(self):
        return self._rank

    @rank.setter
    def rank(self, value: int):
        if self._rank != value:
            self._rank = value
            self.rankChanged.emit(value)

    @pyqtProperty(int, notify=wealthChanged)
    def wealth(self):
        return self._wealth

    @wealth.setter
    def wealth(self, value: int):
        if self._wealth != value:
            self._wealth = value
            self.wealthChanged.emit(value)

    @pyqtProperty(str, notify=nameChanged)
    def name(self):
        return self._name

    @name.setter
    def name(self, value):
        if self._name != value:
            self._name = value
            self.nameChanged.emit(value)

    @pyqtProperty(int, notify=contentWidthChanged)
    def contentWidth(self):
        return self._content_width

    @pyqtProperty(int, notify=contentHeightChanged)
    def contentHeight(self):
        return self._content_height

    @pyqtProperty(str, notify=currentPageChanged)
    def currentPage(self):
        return self._current_page

    @currentPage.setter
    def currentPage(self, value):
        if self._current_page != value:
            self._current_page = value
            self.currentPageChanged.emit(value)
