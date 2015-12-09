% test_IdManager
clear all

[basedir, folder, idfile] = IdManager.getSetup()
IdManager.setupInit()
[basedir, folder, idfile] = IdManager.getSetup()

rm = RecordManager('d', 'testFile\garbage\RMSample', 'f', 'sample.mat');
[basedir, folder, idfile] = IdManager.getSetup()

IdManager.dirname(rm)
IdManager.filename(rm)

%{
input('');
IdManager.delete_idfile(rm)
input('');
IdManager.delete_setup()
%}