import QtQuick 2.5
import "./match"
import "./home"
import "./wealth_distribution"
import "./wait_proposal"
import "./proposal"
import "./result"

Item{
    width: 800; height: 500
    Home {
        visible: viewModel.currentPage == "home"
        anchors.centerIn: parent
    }
    Match {
        visible: viewModel.currentPage == "match"
        anchors.centerIn: parent
    }

    WealthDistribution {
        visible: viewModel.currentPage == "wealth_distribution"
        anchors.centerIn: parent
    }

    WaitProposal {
        visible: viewModel.currentPage == "wait_proposal"
        anchors.centerIn: parent
    }
    Proposal {
        visible: viewModel.currentPage == "proposal"
        anchors.centerIn: parent
    }

    Result {
        visible: viewModel.currentPage == "result"
        anchors.centerIn: parent
    }
}