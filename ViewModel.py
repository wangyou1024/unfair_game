from PyQt5.QtCore import QObject, pyqtProperty, pyqtSignal, pyqtSlot, QTimer
import random

class ViewModel(QObject):
    HOME_PAGE = "home"
    MATCH_PAGE = "match"
    WEALTH_DISTRIBUTION_PAGE = "wealth_distribution"
    WAIT_PROPOSAL_PAGE = "wait_proposal"
    PROPOSAL_PAGE = "proposal"
    RESULT_PAGE = "result"
    START_OVER="start_over"

    def __init__(self):
        super().__init__()
        self._content_width = 800
        self._content_height = 500
        self._name = "王游"
        self._wealth = 100
        self._rank = 1000
        self._current_page = self.HOME_PAGE
        self._randomValue = 1
        self._matcherAccountNum=234
        # # init
        # self.personList = [100+20, 100+40, 100+60, 15000]
        #
        # # matching
        # self.matcherIndex = random.randint(0, len(self.personList)-1)
        # # self._matcherName = ""
        # self.matcherAccountNum = self.personList[self.matcherIndex]
        #
        # # result
        # # self.matcherAccountNum = self.matcherAccountNum + 10-proposal
        # self.personList[self.matcherIndex] = self.personList[self.matcherIndex] + 10-self.randomValue
        #
        
    contentWidthChanged = pyqtSignal(int)
    contentHeightChanged = pyqtSignal(int)
    nameChanged = pyqtSignal(str)
    wealthChanged = pyqtSignal(int)
    rankChanged = pyqtSignal(int)
    currentPageChanged = pyqtSignal(str)
    randomValueChanged = pyqtSignal(int)
    matcherAccountNumChanged = pyqtSignal(int)

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
        QTimer.singleShot(1000, self.openProposal)

    @pyqtSlot()
    def openProposal(self):
        self.randomValue = random.randint(1, 3)
        self.currentPage = self.PROPOSAL_PAGE

    @pyqtSlot()
    def openStart(self):
        self.currentPage = self.START_OVER

    @pyqtSlot()
    def openResult(self):
        self.currentPage = self.RESULT_PAGE
        QTimer.singleShot(1000, self.openHome)

    @pyqtSlot()
    def agreeProposal(self):
        self.wealth = self.wealth + self.randomValue
        self.matcherAccountNum = self.matcherAccountNum + (10-self.randomValue)
        print("同意")
        self.openResult()

    @pyqtSlot()
    def disagreeProposal(self):
        self.randomValue = 0
        print("不同意")
        self.openResult()

    @pyqtProperty(int, notify=rankChanged)
    def rank(self):
        return self._rank
    
    @rank.setter
    def rank(self, value: int):
        if self._rank != value:
            self._rank = value
            self.rankChanged.emit(value)

    @pyqtProperty(int, notify=matcherAccountNumChanged)
    def matcherAccountNum(self):
        return self._matcherAccountNum
    
    @matcherAccountNum.setter
    def matcherAccountNum(self, value: int):
        if self._matcherAccountNum != value:
            self._matcherAccountNum = value
            self.matcherAccountNumChanged.emit(value)



    @pyqtProperty(int, notify=wealthChanged)
    def wealth(self):
        return self._wealth
    
    @wealth.setter
    def wealth(self, value: int):
        if self._wealth != value:
            self._wealth = value
            self.wealthChanged.emit(value)

    @pyqtProperty(int, notify=randomValueChanged)
    def randomValue(self):
        return self._randomValue

    @randomValue.setter
    def randomValue(self, value: int):
        if self._randomValue != value:
            self._randomValue = value
            self.randomValueChanged.emit(value)

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
