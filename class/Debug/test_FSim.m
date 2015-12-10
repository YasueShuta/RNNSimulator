% test FORCESimulator

clear all
IdManager.reset();
sim = FORCESimulator()
sim.force.set('r_alpha', 0.001);

sim.initialize();

sim.nTimeLoop(3);
                        
sim.testLoop();

sim.finalize();