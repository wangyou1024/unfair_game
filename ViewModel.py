from PyQt5.QtCore import QObject, pyqtProperty, pyqtSignal, pyqtSlot, QTimer
import random
from person import Person
from scipy.stats import norm 
import math

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
        self._rank = 150
        self._current_page = self.HOME_PAGE
        self._randomValue = 1
        self._matcher_wealth=234
        self._matcher_name = "李显圣"
        self.personList: list[Person] = []
        self.youIndex = 0
        self.matcherIndex = 0

        self._wealth0_19 = 0
        self._wealth20_39 = 0
        self._wealth40_59 = 0
        self._wealth60_79 = 0
        self._wealth80_99 = 0
        self._wealth100_119 = 0
        self._wealth120_139 = 0
        self._wealth140_159 = 0
        self._wealth160_179 = 0
        self._wealth180_199 = 0
        self.init()

        

        
    contentWidthChanged = pyqtSignal(int)
    contentHeightChanged = pyqtSignal(int)
    nameChanged = pyqtSignal(str)
    wealthChanged = pyqtSignal(int)
    rankChanged = pyqtSignal(int)
    currentPageChanged = pyqtSignal(str)
    randomValueChanged = pyqtSignal(int)
    matcherWealthChanged = pyqtSignal(int)
    matcherNameChanged = pyqtSignal(str)

    wealth0_19Changed = pyqtSignal(int)
    wealth20_39Changed = pyqtSignal(int)
    wealth40_59Changed = pyqtSignal(int)
    wealth60_79Changed = pyqtSignal(int)
    wealth80_99Changed = pyqtSignal(int)
    wealth100_119Changed = pyqtSignal(int)
    wealth120_139Changed = pyqtSignal(int)
    wealth140_159Changed = pyqtSignal(int)
    wealth160_179Changed = pyqtSignal(int)
    wealth180_199Changed = pyqtSignal(int)

    

    def init(self):
        random.seed(2)
        # 打开文件并读取每一行
        file_path = '姓名.txt'  # 替换为你的文件路径

        try:
            with open(file_path, 'r', encoding='utf-8') as file:  # 使用with语句确保文件正确关闭
                lines = file.readlines()  # 读取所有行，每一行作为一个字符串存储在列表中
                lines = [line.strip() for line in lines]  # 去除每行的首尾空白字符（包括换行符）

            # 打印结果
            # print("文件内容（每行为一个元素）：")
            # for index, line in enumerate(lines):
            #     print(f"nameList({index}) = \"{line}\"")
        except FileNotFoundError:
            print(f"文件 {file_path} 未找到，请检查路径是否正确。")
        except Exception as e:
            print(f"读取文件时发生错误：{e}")
        

        # 人员分布
        real_sum = 150
        number = real_sum * 2
        number_array = []
        std_dev = 4700
        lower_index = 100
        gap = 200
        mean = 100
        for i in range(100, 16000, gap) :
            proportion = norm.cdf(i+gap, loc=mean, scale=std_dev) - norm.cdf(lower_index,loc=mean, scale=std_dev)
            temp_number = round(proportion * number)
            temp_sum = sum(number_array)
            if temp_number >= 1 and temp_sum + temp_number <= real_sum:
                number_array.append(temp_number)
                for j in range(temp_number):
                    self.personList.append(Person(lines[temp_sum+j], random.randint(lower_index, i+gap)))
                # 比例达不到1人时，向后累加
                lower_index = i+gap
            elif temp_sum + temp_number > real_sum and temp_sum < real_sum:
                temp_number = real_sum - temp_sum
                number_array.append(temp_number)
                for j in range(temp_number):
                    self.personList.append(Person(lines[temp_sum+j], random.randint(lower_index, i+gap)))
            else:
                temp_number = 0
                number_array.append(temp_number)
                continue
        
                
        # 排序
        self.personList = sorted(self.personList, key= lambda person: person.account)
        # 第一个为被试
        self.personList[0].account = 100
        self.personList[0].name = "被试"
        self.youIndex = 0
        self.rank = len(self.personList)-self.youIndex
    
    def matching(self):
        index = self.youIndex
        if random.randint(0,1) == 0:
            upperIndex = self.youIndex
            for i in range(self.youIndex, len(self.personList)):
                if self.personList[i].account <= self.personList[self.youIndex].account + 200:
                    upperIndex = i
                else:
                    break
            index = random.randint(self.youIndex+1, upperIndex)
            matcher = self.personList[index]
            self.matcherWealth = matcher.account
            self.matcherName = matcher.name
            self.matcherIndex = index
        else:
            lowerIndex = self.youIndex
            for i in range(self.youIndex, len(self.personList)):
                if self.personList[i].account >= 10000:
                    lowerIndex = i
                    break
            index = random.randint(lowerIndex, len(self.personList)-1)    
            matcher = self.personList[index]
            self.matcherWealth = matcher.account
            self.matcherName = matcher.name
            self.matcherIndex = index

    def dealAgree(self):
        self.personList[self.youIndex].account = self.personList[self.youIndex].account + self.randomValue
        self.wealth = self.personList[self.youIndex].account
        self.personList[self.matcherIndex].account = self.personList[self.matcherIndex].account + 10 - self.randomValue
        self.personList = sorted(self.personList, key= lambda person: person.account)
        for i in range(len(self.personList)):
            if self.personList[i].name == "被试":
                self.youIndex = i
                break
        
        self.rank = len(self.personList)-self.youIndex
    
    def dealLast200(self):
        new_last_200 = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ,0]
        for i in range(self.youIndex, len(self.personList)):
            index = math.floor((self.personList[i].account - self.personList[self.youIndex].account)/20)
            if index > 9:
                break
            if index >= 0 and index <=9:
                new_last_200[index] = new_last_200[index]+1
        # 去掉被试自己
        new_last_200[0] = new_last_200[0]-1
        self.wealth0_19 = new_last_200[0]
        self.wealth20_39 = new_last_200[1]
        self.wealth40_59 = new_last_200[2]
        self.wealth60_79 = new_last_200[3]
        self.wealth80_99 = new_last_200[4]
        self.wealth100_119 = new_last_200[5]
        self.wealth120_139 = new_last_200[6]
        self.wealth140_159 = new_last_200[7]
        self.wealth160_179 = new_last_200[8]
        self.wealth180_199 = new_last_200[9]
        
    @pyqtSlot()
    def openHome(self):
        self.currentPage = self.HOME_PAGE

    @pyqtSlot()
    def openMatch(self):
        self.matching()
        self.dealLast200()
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
        self.randomValue = random.choice([1, 3, 5])
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
        self.dealAgree()
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

    @pyqtProperty(int, notify=matcherWealthChanged)
    def matcherWealth(self):
        return self._matcher_wealth
    
    @matcherWealth.setter
    def matcherWealth(self, value: int):
        if self._matcher_wealth != value:
            self._matcher_wealth = value
            self.matcherWealthChanged.emit(value)

    @pyqtProperty(str, notify=matcherNameChanged)
    def matcherName(self):
        return self._matcher_name
    
    @matcherName.setter
    def matcherName(self, value: int):
        if self._matcher_name != value:
            self._matcher_name = value
            self.matcherNameChanged.emit(value)

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

    @pyqtProperty(int, notify=wealth0_19Changed)
    def wealth0_19(self):
        return self._wealth0_19

    @wealth0_19.setter
    def wealth0_19(self, value):
        if self._wealth0_19 != value:
            self._wealth0_19 = value
            self.wealth0_19Changed.emit(value)

    @pyqtProperty(int, notify=wealth20_39Changed)
    def wealth20_39(self):
        return self._wealth20_39

    @wealth20_39.setter
    def wealth20_39(self, value):
        if self._wealth20_39 != value:
            self._wealth20_39 = value
            self.wealth20_39Changed.emit(value)

    @pyqtProperty(int, notify=wealth40_59Changed)
    def wealth40_59(self):
        return self._wealth40_59

    @wealth40_59.setter
    def wealth40_59(self, value):
        if self._wealth40_59 != value:
            self._wealth40_59 = value
            self.wealth40_59Changed.emit(value)

    @pyqtProperty(int, notify=wealth60_79Changed)
    def wealth60_79(self):
        return self._wealth60_79

    @wealth60_79.setter
    def wealth60_79(self, value):
        if self._wealth60_79 != value:
            self._wealth60_79 = value
            self.wealth60_79Changed.emit(value)

    @pyqtProperty(int, notify=wealth80_99Changed)
    def wealth80_99(self):
        return self._wealth80_99

    @wealth80_99.setter
    def wealth80_99(self, value):
        if self._wealth80_99 != value:
            self._wealth80_99 = value
            self.wealth80_99Changed.emit(value)
    
    @pyqtProperty(int, notify=wealth100_119Changed)
    def wealth100_119(self):
        return self._wealth100_119

    @wealth100_119.setter
    def wealth100_119(self, value):
        if self._wealth100_119 != value:
            self._wealth100_119 = value
            self.wealth100_119Changed.emit(value)

    @pyqtProperty(int, notify=wealth120_139Changed)
    def wealth120_139(self):
        return self._wealth120_139

    @wealth120_139.setter
    def wealth120_139(self, value):
        if self._wealth120_139 != value:
            self._wealth120_139 = value
            self.wealth120_139Changed.emit(value)

    @pyqtProperty(int, notify=wealth140_159Changed)
    def wealth140_159(self):
        return self._wealth140_159

    @wealth140_159.setter
    def wealth140_159(self, value):
        if self._wealth140_159 != value:
            self._wealth140_159 = value
            self.wealth140_159Changed.emit(value)

    @pyqtProperty(int, notify=wealth160_179Changed)
    def wealth160_179(self):
        return self._wealth160_179

    @wealth160_179.setter
    def wealth160_179(self, value):
        if self._wealth160_179 != value:
            self._wealth160_179 = value
            self.wealth160_179Changed.emit(value)

    @pyqtProperty(int, notify=wealth180_199Changed)
    def wealth180_199(self):
        return self._wealth180_199

    @wealth180_199.setter
    def wealth180_199(self, value):
        if self._wealth180_199 != value:
            self._wealth180_199 = value
            self.wealth180_199Changed.emit(value)
    
