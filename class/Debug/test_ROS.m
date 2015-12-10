% test_RNNObserverSet
clear all
recordManager = RecordManager.init('testFile\garbage')

rnn = RNN.init()
ros = RNNObserverSet.init(rnn, 'in_rnn')
ros.set('cellNum', 10)
ros

