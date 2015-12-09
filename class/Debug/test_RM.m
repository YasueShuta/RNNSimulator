clear all
rm = RecordManager(); rm.id                   % id = 1

rm = RecordManager('flag', 'updateId'); rm.id % id = 2
rm = RecordManager('flag', 'updateId'); rm.id % id = 3
rm = RecordManager(); rm.id                   % id = 3
rm.set('idfile', 'id2.mat'); rm.id            % id = 1


rm = RecordManager.init('testFile'); rm.id    % id = 1

RecordManager.getObject()

rm = RecordManager(); rm.id                   % id = 4
rm = RecordManager('f', 'id2.mat'); rm.id     % id = 2

RecordManager.getObject()
