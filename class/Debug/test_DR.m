% test_DataRecorder
clear all
dr = DataRecorder('basedir', strcat(pwd, '\testFile'), 'f', 'test.mat')
IdManager.filename
IdManager.dirname(dr)

IdManager.delete_idfile(dr);
IdManager.delete_setup();
